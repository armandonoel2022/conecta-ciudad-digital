
import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import AppSidebar from '@/components/AppSidebar';
import { Menu, X } from 'lucide-react';
import { Button } from './ui/button';
import logoCiudadConecta from '@/assets/logo-ciudadconecta-v2-simple.png';

const Layout = () => {
  const [sidebarOpen, setSidebarOpen] = useState(false);

  return (
    <div className="flex h-screen bg-gradient-to-br from-primary via-blue-600 to-indigo-700">
      <div className={`fixed inset-y-0 left-0 z-30 w-64 bg-white/95 backdrop-blur-sm shadow-xl transform ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'} transition-transform duration-300 ease-in-out md:relative md:flex md:flex-shrink-0 ${sidebarOpen ? 'md:translate-x-0' : 'md:-translate-x-full'}`}>
        <AppSidebar closeSidebar={() => setSidebarOpen(false)} />
      </div>

      <div className="flex-1 flex flex-col overflow-hidden">
        <header className="flex items-center justify-between p-4 bg-white/10 backdrop-blur-sm border-b border-white/20">
          <Button 
            variant="ghost" 
            onClick={() => setSidebarOpen(!sidebarOpen)} 
            className="flex items-center space-x-3 text-white hover:bg-white/20 px-3 py-2 rounded-xl transition-all duration-300 hover:scale-105"
          >
            <div className="w-8 h-8 rounded-lg flex items-center justify-center transition-transform duration-300 hover:rotate-12">
              <img 
                src={logoCiudadConecta} 
                alt="CiudadConecta" 
                className="w-full h-full object-contain drop-shadow-lg"
              />
            </div>
            <h1 className="text-xl font-bold">CiudadConecta</h1>
          </Button>
          <Button variant="ghost" size="icon" onClick={() => setSidebarOpen(!sidebarOpen)} className="text-white hover:bg-white/20 md:hidden">
            {sidebarOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
          </Button>
        </header>

        <main className="flex-1 overflow-y-auto">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default Layout;
