import React from 'react';
import { useNavigate } from 'react-router-dom';

const EditProfile: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-background pb-20">
      {/* Header */}
      <header className="sticky top-0 z-50 bg-white border-b border-slate-100 px-4 py-3 flex items-center justify-between">
        <button onClick={() => navigate(-1)} className="flex items-center justify-center w-10 h-10 rounded-full text-slate-900 hover:bg-slate-50 transition-colors">
          <span className="material-symbols-outlined text-2xl">arrow_back_ios_new</span>
        </button>
        <h1 className="text-lg font-bold text-slate-900 flex-1 text-center">编辑个人资料</h1>
        <div className="w-10"></div> 
      </header>

      <main className="flex-1 flex flex-col items-center w-full px-4 pt-6">
        {/* Avatar */}
        <section className="w-full py-6 flex flex-col items-center justify-center gap-4">
          <div className="relative group cursor-pointer">
            <div className="w-28 h-28 rounded-full overflow-hidden border-4 border-white shadow-sm bg-gray-200">
              <img 
                alt="profile" 
                className="w-full h-full object-cover" 
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBVN-4BrMxVgEjtGZz8u-S348rnUnKkQ_rxTzYdzVFfYvHjhrd8Ox64RZilbMZjs7sNo_Mj7rD-FL7Hqlxd5yfloBqYbziPGWg5vPHKJNj4OUMVVcpsDdl5i4UqWzZ0qlG0gCmo5KYsnCEhVawu608eB8OVVyf2TgSR_QLbzkxbUZNain9Gly7UWMoktw6mH4mV7SK3s4UWeJMgkB-2g2v44Pi7G2zgfbHIKUBYPfV-85V5LZV_qyx19xe9RnjscTy6CKTJUl6FDLs" 
              />
            </div>
            <div className="absolute bottom-0 right-0 bg-primary text-white p-2 rounded-full border-2 border-background flex items-center justify-center shadow-md">
              <span className="material-symbols-outlined text-sm font-bold">photo_camera</span>
            </div>
          </div>
          <p className="text-primary font-medium text-sm tracking-wide cursor-pointer hover:underline">点击修改头像</p>
        </section>

        {/* Basic Info */}
        <section className="w-full mb-6">
          <h3 className="text-sm font-semibold text-slate-500 mb-2 px-1">基本信息</h3>
          <div className="bg-white rounded-xl shadow-card border border-slate-100 overflow-hidden divide-y divide-slate-100">
            {['姓名', '性别', '出生日期', '手机号'].map((label, i) => (
              <div key={i} className="flex items-center justify-between p-4 hover:bg-slate-50 cursor-pointer transition-colors">
                <span className="text-slate-900 font-medium text-base">{label}</span>
                <div className="flex items-center gap-2 text-slate-500">
                  <span className="text-base">{['李先生', '男', '1980-05-20', '138****0000'][i]}</span>
                  <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Health Stats */}
        <section className="w-full mb-6">
          <h3 className="text-sm font-semibold text-slate-500 mb-2 px-1">健康概况</h3>
          <div className="bg-white rounded-xl shadow-card border border-slate-100 overflow-hidden divide-y divide-slate-100">
            {['身高 (cm)', '体重 (kg)', '血型', '是否过敏'].map((label, i) => (
              <div key={i} className="flex items-center justify-between p-4 hover:bg-slate-50 cursor-pointer transition-colors">
                <span className="text-slate-900 font-medium text-base">{label}</span>
                <div className="flex items-center gap-2 text-slate-500">
                  <span className="text-base">{['175', '70', 'A型', '无'][i]}</span>
                  <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
                </div>
              </div>
            ))}
          </div>
        </section>

        {/* Medical History */}
        <section className="w-full mb-6">
          <h3 className="text-sm font-semibold text-slate-500 mb-2 px-1">影像分析相关背景</h3>
          <div className="bg-white rounded-xl shadow-card border border-slate-100 overflow-hidden divide-y divide-slate-100">
             {['是否有吸烟史', '既往肺部疾病', '是否有心脏病史'].map((label, i) => (
              <div key={i} className="flex items-center justify-between p-4 hover:bg-slate-50 cursor-pointer transition-colors">
                <span className="text-slate-900 font-medium text-base">{label}</span>
                <div className="flex items-center gap-2 text-slate-500">
                  <span className="text-base">{['是 (已戒烟)', '无', '否'][i]}</span>
                  <span className="material-symbols-outlined text-slate-400 text-[20px]">chevron_right</span>
                </div>
              </div>
            ))}
          </div>
          <p className="mt-4 px-2 text-xs text-slate-400 leading-relaxed">
            您的个人医疗信息将用于AI辅助诊断，请确保信息真实有效。数据已加密保护。
          </p>
        </section>
      </main>

      {/* Footer Button */}
      <footer className="fixed bottom-0 w-full max-w-md mx-auto bg-white border-t border-slate-100 p-4 z-40 pb-safe">
        <button className="w-full bg-primary hover:bg-primary-dark active:bg-blue-700 text-white font-bold text-base h-12 rounded-full shadow-float transition-all flex items-center justify-center gap-2">
          <span className="material-symbols-outlined text-[20px]">save</span>
          保存并更新
        </button>
      </footer>
    </div>
  );
};

export default EditProfile;