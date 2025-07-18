import { useState, useEffect, useCallback } from 'react';

interface AlertSoundOptions {
  type: 'amber' | 'panic';
  title: string;
  message: string;
  autoPlay?: boolean;
}

export const useAlertSound = () => {
  const [audioContext, setAudioContext] = useState<AudioContext | null>(null);
  const [hasPermission, setHasPermission] = useState(false);
  const [audioInitialized, setAudioInitialized] = useState(false);

  // Initialize audio context and check permissions
  useEffect(() => {
    const initAudio = async () => {
      try {
        // Request notification permission
        if ('Notification' in window) {
          const permission = await Notification.requestPermission();
          setHasPermission(permission === 'granted');
        }

        // Initialize audio context immediately
        const initAudioContext = () => {
          try {
            const context = new (window.AudioContext || (window as any).webkitAudioContext)();
            setAudioContext(context);
            setAudioInitialized(true);
            console.log('Audio context initialized successfully');
            
            // Remove event listeners after initialization
            document.removeEventListener('click', initAudioContext);
            document.removeEventListener('touchstart', initAudioContext);
            document.removeEventListener('keydown', initAudioContext);
          } catch (error) {
            console.error('Error initializing audio context:', error);
          }
        };

        // Try to initialize immediately
        initAudioContext();

        // If it fails due to autoplay policy, add event listeners for user interaction
        if (!audioInitialized) {
          document.addEventListener('click', initAudioContext, { once: true });
          document.addEventListener('touchstart', initAudioContext, { once: true });
          document.addEventListener('keydown', initAudioContext, { once: true });
        }
      } catch (error) {
        console.error('Error initializing audio:', error);
      }
    };

    initAudio();
  }, []);

  // Generate alert tone using Web Audio API
  const generateAlertTone = useCallback((frequency: number, duration: number, type: 'sine' | 'square' = 'sine') => {
    if (!audioContext) return;

    const oscillator = audioContext.createOscillator();
    const gainNode = audioContext.createGain();

    oscillator.connect(gainNode);
    gainNode.connect(audioContext.destination);

    oscillator.frequency.setValueAtTime(frequency, audioContext.currentTime);
    oscillator.type = type;

    // Create envelope for smoother sound
    gainNode.gain.setValueAtTime(0, audioContext.currentTime);
    gainNode.gain.linearRampToValueAtTime(0.3, audioContext.currentTime + 0.01);
    gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + duration);

    oscillator.start(audioContext.currentTime);
    oscillator.stop(audioContext.currentTime + duration);
  }, [audioContext]);

  // Play alert sound sequence
  const playAlertSound = useCallback(async (type: 'amber' | 'panic') => {
    if (!audioContext) {
      console.log('Audio context not available');
      return;
    }

    try {
      // Resume audio context if suspended
      if (audioContext.state === 'suspended') {
        console.log('Resuming suspended audio context');
        await audioContext.resume();
      }

      console.log(`Playing ${type} alert sound`);

      if (type === 'amber') {
        // Amber alert: alternating high-low tones
        generateAlertTone(800, 0.5);
        setTimeout(() => generateAlertTone(600, 0.5), 600);
        setTimeout(() => generateAlertTone(800, 0.5), 1200);
        setTimeout(() => generateAlertTone(600, 0.5), 1800);
      } else {
        // Panic alert: urgent beeping pattern
        generateAlertTone(1000, 0.2, 'square');
        setTimeout(() => generateAlertTone(1000, 0.2, 'square'), 300);
        setTimeout(() => generateAlertTone(1000, 0.2, 'square'), 600);
        setTimeout(() => generateAlertTone(1200, 0.8, 'square'), 900);
      }
    } catch (error) {
      console.error('Error playing alert sound:', error);
    }
  }, [audioContext, generateAlertTone]);

  // Show browser notification
  const showNotification = useCallback((options: AlertSoundOptions) => {
    if (!hasPermission || !('Notification' in window)) return;

    const notification = new Notification(options.title, {
      body: options.message,
      icon: '/logo.svg',
      badge: '/logo.svg',
      tag: `alert-${options.type}`,
      requireInteraction: true,
      silent: false
    });

    // Auto close notification after 10 seconds
    setTimeout(() => {
      notification.close();
    }, 10000);

    return notification;
  }, [hasPermission]);

  // Force initialize audio context
  const forceInitAudio = useCallback(async () => {
    if (audioContext && audioContext.state === 'suspended') {
      try {
        await audioContext.resume();
        console.log('Audio context resumed successfully');
        return true;
      } catch (error) {
        console.error('Error resuming audio context:', error);
        return false;
      }
    }
    
    if (!audioContext) {
      try {
        const context = new (window.AudioContext || (window as any).webkitAudioContext)();
        setAudioContext(context);
        setAudioInitialized(true);
        console.log('Audio context force initialized successfully');
        return true;
      } catch (error) {
        console.error('Error force initializing audio context:', error);
        return false;
      }
    }
    
    return true;
  }, [audioContext]);

  // Main alert function
  const triggerAlert = useCallback(async (options: AlertSoundOptions) => {
    // Force initialize audio before playing
    await forceInitAudio();
    
    // Play sound directly - don't check audioReady flag since forceInitAudio handles it
    if (options.autoPlay !== false) {
      console.log(`Calling playAlertSound for ${options.type} from triggerAlert`);
      playAlertSound(options.type);
    }

    // Show notification if app is not visible
    if (document.hidden || document.visibilityState === 'hidden') {
      showNotification(options);
    }

    // Vibrate if supported (mobile devices)
    if ('vibrate' in navigator) {
      if (options.type === 'amber') {
        navigator.vibrate([500, 200, 500, 200, 500]);
      } else {
        navigator.vibrate([200, 100, 200, 100, 200, 100, 800]);
      }
    }
  }, [playAlertSound, showNotification, forceInitAudio]);

  return {
    triggerAlert,
    playAlertSound,
    forceInitAudio,
    hasPermission,
    isAudioReady: !!audioContext && audioInitialized
  };
};