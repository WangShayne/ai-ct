import React from 'react';
import { useNavigate } from 'react-router-dom';

const Feedback: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-background">
      {/* Top App Bar */}
      <div className="sticky top-0 z-50 flex items-center bg-white p-4 border-b border-gray-200">
        <button onClick={() => navigate(-1)} className="flex size-10 shrink-0 items-center justify-center rounded-full hover:bg-gray-100 cursor-pointer text-slate-900">
          <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <h2 className="flex-1 text-center text-lg font-bold leading-tight tracking-[-0.015em] pr-10 text-slate-900">意见反馈与帮助</h2>
      </div>

      <main className="flex-1 flex flex-col pb-24">
        {/* Issue Description Section */}
        <div className="flex flex-col gap-2 p-4 pt-6">
          <label className="text-sm font-bold leading-tight tracking-tight px-1 text-slate-900">
            问题描述 <span className="text-red-500">*</span>
          </label>
          <textarea 
            className="w-full resize-none rounded-xl border border-gray-200 bg-white p-4 text-base text-slate-900 placeholder-gray-400 focus:border-primary focus:ring-1 focus:ring-primary min-h-[140px] shadow-sm outline-none" 
            placeholder="请详细描述您遇到的问题或建议，以帮助我们改进产品..."
          ></textarea>
        </div>

        {/* Image Upload Section */}
        <div className="flex flex-col gap-3 px-4 py-2">
          <div className="flex justify-between items-end px-1">
            <h3 className="text-sm font-bold leading-tight text-slate-900">添加图片</h3>
            <span className="text-xs text-gray-500">选填，最多3张</span>
          </div>
          <div className="grid grid-cols-3 gap-3">
            {/* Uploaded Image Preview */}
            <div className="relative group aspect-square w-full rounded-xl bg-gray-100 overflow-hidden border border-gray-200">
              <div className="absolute top-1 right-1 z-10 bg-black/50 hover:bg-red-500 text-white rounded-full p-0.5 cursor-pointer">
                <span className="material-symbols-outlined text-[16px]">close</span>
              </div>
              <div 
                className="w-full h-full bg-center bg-no-repeat bg-cover" 
                style={{ backgroundImage: 'url("https://lh3.googleusercontent.com/aida-public/AB6AXuAPlZl4BZM3V_AK7WnMcUeJz2eSboEpnGICrUO1Kq83Y3Y-QiUTZ8JLZna3XgwsOt1djdAQe-sxfrgx3FOdH5RwJMdJgu_2mhu3TQuLERHXw11hX6vDpJAKn5J8P6eBo22qrdbWbscUq56I1fPuyCzS9_wDMpQ8fZZGpZouW909N72uWKIIylp5YxQWum6Em6VofuTo0OYjcz8J6mYJZDpq1ZPVDVrpaNe0GpeLe-6t-YL4gmmqC7GItKAlEHRCnBUEjXiW0AA4xJw")' }}
              ></div>
            </div>
            {/* Upload Slot 1 */}
            <div className="flex flex-col items-center justify-center aspect-square w-full rounded-xl border-2 border-dashed border-gray-300 bg-white text-primary hover:bg-primary/5 cursor-pointer transition-colors">
              <span className="material-symbols-outlined text-3xl">add_a_photo</span>
            </div>
            {/* Upload Slot 2 */}
            <div className="flex flex-col items-center justify-center aspect-square w-full rounded-xl border-2 border-dashed border-gray-300 bg-white text-gray-300 hover:text-primary hover:bg-primary/5 cursor-pointer transition-colors">
              <span className="material-symbols-outlined text-3xl">add</span>
            </div>
          </div>
        </div>

        {/* Contact Info */}
        <div className="flex flex-col gap-2 p-4 pb-6 border-b border-gray-200">
          <label className="text-sm font-bold leading-tight tracking-tight px-1 text-slate-900">
            联系方式
          </label>
          <div className="relative">
            <div className="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none text-gray-500">
              <span className="material-symbols-outlined text-[20px]">mail</span>
            </div>
            <input 
              className="w-full rounded-xl border border-gray-200 bg-white py-3 pl-10 pr-4 text-base text-slate-900 placeholder-gray-400 focus:border-primary focus:ring-1 focus:ring-primary shadow-sm outline-none" 
              placeholder="请输入您的邮箱或手机号" 
              type="text"
            />
          </div>
        </div>

        {/* FAQ Section */}
        <div className="flex flex-col gap-4 p-4 pt-6">
          <h3 className="text-lg font-bold leading-tight text-slate-900 px-1">常见问题 (FAQ)</h3>
          
          <div className="flex flex-col overflow-hidden rounded-xl bg-white shadow-card border border-gray-100">
            <div className="flex w-full items-center justify-between p-4 pb-2">
              <span className="text-base font-semibold text-slate-900">如何拍摄更清晰的影像?</span>
              <span className="material-symbols-outlined text-gray-500 transform rotate-180">expand_less</span>
            </div>
            <div className="px-4 pb-4 text-sm leading-relaxed text-slate-600">
              为了获得最佳的 AI 分析结果，请确保拍摄时光线充足，将手机与胶片保持平行，并避免屏幕反光。建议使用纯色背景。
            </div>
          </div>
          
          <div className="flex flex-col overflow-hidden rounded-xl bg-white shadow-card border border-gray-100">
            <div className="flex w-full items-center justify-between p-4 cursor-pointer hover:bg-gray-50">
              <span className="text-base font-medium text-slate-900">AI 分析需要多长时间?</span>
              <span className="material-symbols-outlined text-gray-500">expand_more</span>
            </div>
          </div>

          <div className="flex flex-col overflow-hidden rounded-xl bg-white shadow-card border border-gray-100">
            <div className="flex w-full items-center justify-between p-4 cursor-pointer hover:bg-gray-50">
              <span className="text-base font-medium text-slate-900">我的医疗数据是否安全?</span>
              <span className="material-symbols-outlined text-gray-500">expand_more</span>
            </div>
          </div>
        </div>

        {/* Footer Disclaimer */}
        <div className="px-6 py-4 text-center">
          <p className="text-xs text-gray-400 leading-normal">
            注意：此反馈表格仅用于应用技术支持和功能建议。如遇紧急医疗情况，请立即联系医生或前往医院就诊。
          </p>
        </div>
      </main>

      {/* Sticky Bottom Button */}
      <div className="fixed bottom-0 left-0 right-0 p-4 bg-white border-t border-gray-200 z-10 max-w-md mx-auto pb-safe">
        <button className="flex w-full items-center justify-center gap-2 rounded-xl bg-primary px-6 py-3.5 text-base font-bold tracking-tight text-white shadow-float transition-transform active:scale-[0.98] hover:bg-primary-dark">
          <span>提交反馈</span>
        </button>
      </div>
    </div>
  );
};

export default Feedback;