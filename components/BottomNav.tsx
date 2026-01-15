import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';

const BottomNav: React.FC = () => {
  const navigate = useNavigate();
  const location = useLocation();

  const getIconStyle = (path: string) => {
    const isActive = location.pathname === path;
    return isActive 
      ? "text-primary fill-current font-variation-settings-fill" 
      : "text-slate-400";
  };
  
  const getTextStyle = (path: string) => {
    const isActive = location.pathname === path;
    return isActive ? "text-primary font-bold" : "text-slate-400 font-medium";
  };

  return (
    <div className="absolute bottom-0 w-full bg-white border-t border-slate-100 pb-safe pt-2 z-50">
      <div className="flex justify-around items-end h-14">
        <button 
          onClick={() => navigate('/')}
          className="flex flex-col items-center gap-1 w-16"
        >
          <span className={`material-symbols-outlined text-[26px] ${location.pathname === '/' ? 'text-primary' : 'text-slate-400'}`} style={{ fontVariationSettings: location.pathname === '/' ? "'FILL' 1" : "'FILL' 0" }}>home</span>
          <span className={`text-[10px] ${getTextStyle('/')}`}>首页</span>
        </button>

        <button 
          onClick={() => navigate('/files')}
          className="flex flex-col items-center gap-1 w-16"
        >
          <span className={`material-symbols-outlined text-[26px] ${location.pathname === '/files' ? 'text-primary' : 'text-slate-400'}`} style={{ fontVariationSettings: location.pathname === '/files' ? "'FILL' 1" : "'FILL' 0" }}>folder_shared</span>
          <span className={`text-[10px] ${getTextStyle('/files')}`}>档案</span>
        </button>

        <button 
          onClick={() => navigate('/profile')}
          className="flex flex-col items-center gap-1 w-16"
        >
          <span className={`material-symbols-outlined text-[26px] ${location.pathname === '/profile' ? 'text-primary' : 'text-slate-400'}`} style={{ fontVariationSettings: location.pathname === '/profile' ? "'FILL' 1" : "'FILL' 0" }}>settings</span>
          <span className={`text-[10px] ${getTextStyle('/profile')}`}>设置</span>
        </button>
      </div>
    </div>
  );
};

export default BottomNav;