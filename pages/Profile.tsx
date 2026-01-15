import React from 'react';
import { useNavigate } from 'react-router-dom';

const Profile: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-background">
      <header className="flex items-center bg-white p-4 pb-2 justify-between sticky top-0 z-10 border-b border-slate-100">
        <div className="size-12"></div>
        <h2 className="text-slate-900 text-lg font-bold leading-tight flex-1 text-center">个人中心</h2>
        <div className="w-12"></div>
      </header>

      <main className="flex-1 px-4 py-6">
        {/* User Info Card */}
        <div className="bg-white rounded-2xl p-6 mb-6 shadow-card flex items-center gap-5">
          <div className="relative">
            <div className="flex items-center justify-center bg-slate-100 rounded-full h-20 w-20 ring-4 ring-primary/5">
              <span className="material-symbols-outlined text-slate-300 text-[48px]" style={{ fontVariationSettings: "'FILL' 1" }}>person</span>
            </div>
            <div className="absolute bottom-0 right-0 bg-primary text-white p-1 rounded-full border-2 border-white flex items-center justify-center">
              <span className="material-symbols-outlined text-[16px]">verified</span>
            </div>
          </div>
          <div className="flex flex-col justify-center">
            <h3 className="text-slate-900 text-xl font-bold leading-tight mb-1">李先生</h3>
            <p className="text-slate-500 text-sm font-medium">已加入健康管理 365 天</p>
            <p className="text-slate-400 text-xs mt-1 font-mono">ID: 8839201</p>
          </div>
        </div>

        {/* Menu Sections */}
        <div className="space-y-6">
          {/* Section 1 */}
          <div>
            <h4 className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2 ml-2">个人资料</h4>
            <div className="bg-white rounded-xl overflow-hidden shadow-card">
              <div onClick={() => navigate('/profile/edit')} className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">person</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">基本信息</p>
                <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
              </div>
            </div>
          </div>

          {/* Section 2 */}
          <div>
            <h4 className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2 ml-2">偏好设置</h4>
            <div className="bg-white rounded-xl overflow-hidden shadow-card divide-y divide-slate-50">
              <div onClick={() => navigate('/notifications')} className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">notifications</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">消息通知</p>
                <label className="relative inline-flex items-center cursor-pointer" onClick={(e) => e.stopPropagation()}>
                  <input type="checkbox" className="sr-only peer" defaultChecked />
                  <div className="w-11 h-6 bg-slate-200 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary"></div>
                </label>
              </div>
              <div className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">cleaning_services</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">清除缓存</p>
                <div className="flex items-center gap-2">
                  <span className="text-sm text-slate-500">24MB</span>
                  <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
                </div>
              </div>
              <div className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">translate</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">多语言切换</p>
                <div className="flex items-center gap-2">
                  <span className="text-sm text-slate-500">简体中文</span>
                  <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
                </div>
              </div>
            </div>
          </div>

          {/* Section 3 */}
          <div>
            <h4 className="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-2 ml-2">关于与支持</h4>
            <div className="bg-white rounded-xl overflow-hidden shadow-card divide-y divide-slate-50">
              <div className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">menu_book</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">使用指南</p>
                <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
              </div>
              <div onClick={() => navigate('/feedback')} className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">feedback</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">意见反馈</p>
                <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
              </div>
              <div className="flex items-center gap-4 p-4 cursor-pointer active:bg-slate-50 transition-colors">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">info</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">关于我们</p>
                <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
              </div>
              <div className="flex items-center gap-4 p-4 cursor-default">
                <div className="text-primary flex items-center justify-center rounded-lg bg-primary/10 shrink-0 size-9">
                  <span className="material-symbols-outlined text-[20px]">update</span>
                </div>
                <p className="text-slate-900 text-base font-medium flex-1">版本号</p>
                <span className="text-sm text-slate-400 font-mono">v1.0.2</span>
              </div>
            </div>
          </div>

          <button className="w-full bg-white text-red-500 font-bold text-base py-4 rounded-xl shadow-card active:bg-red-50 transition-colors flex items-center justify-center gap-2">
            <span className="material-symbols-outlined">logout</span>
            退出登录
          </button>
        </div>
      </main>
    </div>
  );
};

export default Profile;