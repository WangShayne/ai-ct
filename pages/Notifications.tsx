import React from 'react';
import { useNavigate } from 'react-router-dom';

const Notifications: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="flex flex-col min-h-screen bg-background">
      {/* Header */}
      <header className="flex items-center bg-white px-4 py-3 justify-between sticky top-0 z-20 border-b border-gray-100">
        <button onClick={() => navigate(-1)} className="w-12 flex items-center justify-start text-slate-600">
            <span className="material-symbols-outlined">arrow_back</span>
        </button>
        <h2 className="text-slate-900 text-lg font-bold leading-tight flex-1 text-center">消息通知</h2>
        <button className="flex w-12 items-center justify-end text-primary hover:text-blue-600 transition-colors">
          <span className="material-symbols-outlined text-[20px]" title="全部已读">done_all</span>
        </button>
      </header>

      {/* Tabs */}
      <div className="bg-white pt-1 sticky top-[52px] z-10 shadow-sm">
        <div className="flex border-b border-gray-200 px-4 justify-between gap-4">
          <button className="flex flex-col items-center justify-center border-b-[3px] border-b-primary text-primary pb-3 pt-4 flex-1 transition-all">
            <p className="text-sm font-bold leading-normal">报告提醒</p>
          </button>
          <button className="flex flex-col items-center justify-center border-b-[3px] border-b-transparent text-slate-500 hover:text-slate-900 pb-3 pt-4 flex-1 transition-all">
            <p className="text-sm font-bold leading-normal">系统消息</p>
          </button>
          <button className="flex flex-col items-center justify-center border-b-[3px] border-b-transparent text-slate-500 hover:text-slate-900 pb-3 pt-4 flex-1 transition-all">
            <p className="text-sm font-bold leading-normal">健康科普</p>
          </button>
        </div>
      </div>

      <main className="flex-1 flex flex-col gap-px pb-8">
        {/* Today Section */}
        <div className="px-4 py-3">
          <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider">今日</p>
        </div>

        {/* Item 1 */}
        <div className="bg-white px-4 py-4 cursor-pointer hover:bg-gray-50 transition-colors">
          <div className="flex items-start gap-4 justify-between">
            <div className="flex items-start gap-3 flex-1">
              <div className="flex items-center justify-center rounded-full bg-blue-50 text-primary shrink-0 size-10 mt-0.5">
                <span className="material-symbols-outlined text-[20px]">clinical_notes</span>
              </div>
              <div className="flex flex-col justify-center gap-1">
                <div className="flex items-center gap-2">
                  <p className="text-slate-900 text-base font-semibold leading-tight line-clamp-1">您的肺部CT分析报告已生成</p>
                  <div className="size-2 rounded-full bg-red-500 shrink-0 animate-pulse"></div>
                </div>
                <p className="text-slate-500 text-sm font-normal leading-normal line-clamp-2">
                  智能分析已完成，发现结节风险较低。点击查看详细影像分析结果及医生建议。
                </p>
              </div>
            </div>
            <div className="shrink-0 flex flex-col items-end gap-1">
              <p className="text-gray-400 text-xs font-medium leading-normal">10:30</p>
            </div>
          </div>
        </div>

        {/* Item 2 */}
        <div className="bg-white px-4 py-4 cursor-pointer hover:bg-gray-50 transition-colors border-t border-gray-50">
          <div className="flex items-start gap-4 justify-between">
            <div className="flex items-start gap-3 flex-1">
              <div className="flex items-center justify-center rounded-full bg-emerald-50 text-emerald-600 shrink-0 size-10 mt-0.5">
                <span className="material-symbols-outlined text-[20px]">vaccines</span>
              </div>
              <div className="flex flex-col justify-center gap-1">
                <div className="flex items-center gap-2">
                  <p className="text-slate-900 text-base font-semibold leading-tight line-clamp-1">如何预防冬季呼吸道疾病</p>
                  <div className="size-2 rounded-full bg-red-500 shrink-0"></div>
                </div>
                <p className="text-slate-500 text-sm font-normal leading-normal line-clamp-2">
                  冬季流感高发期，专家建议做好这5点防护措施，守护家人健康。
                </p>
              </div>
            </div>
            <div className="shrink-0 flex flex-col items-end gap-1">
              <p className="text-gray-400 text-xs font-medium leading-normal">09:15</p>
            </div>
          </div>
        </div>

        {/* Yesterday Section */}
        <div className="px-4 py-3 mt-2">
          <p className="text-xs font-semibold text-gray-500 uppercase tracking-wider">昨天</p>
        </div>

        {/* Item 3 */}
        <div className="bg-white px-4 py-4 cursor-pointer hover:bg-gray-50 transition-colors">
          <div className="flex items-start gap-4 justify-between">
            <div className="flex items-start gap-3 flex-1">
              <div className="flex items-center justify-center rounded-full bg-gray-100 text-gray-600 shrink-0 size-10 mt-0.5">
                <span className="material-symbols-outlined text-[20px]">system_update</span>
              </div>
              <div className="flex flex-col justify-center gap-1">
                <p className="text-slate-900 text-base font-medium leading-tight line-clamp-1">版本更新提醒 v2.1</p>
                <p className="text-slate-500 text-sm font-normal leading-normal line-clamp-2">
                  修复了已知Bug，优化了CT影像上传速度，提升了AI分析准确率。
                </p>
              </div>
            </div>
            <div className="shrink-0 flex flex-col items-end gap-1">
              <p className="text-gray-400 text-xs font-medium leading-normal">昨天</p>
            </div>
          </div>
        </div>

        {/* Item 4 */}
        <div className="bg-white px-4 py-4 cursor-pointer hover:bg-gray-50 transition-colors border-t border-gray-50">
          <div className="flex items-start gap-4 justify-between">
            <div className="flex items-start gap-3 flex-1">
              <div className="flex items-center justify-center rounded-full bg-blue-50 text-primary shrink-0 size-10 mt-0.5">
                <span className="material-symbols-outlined text-[20px]">description</span>
              </div>
              <div className="flex flex-col justify-center gap-1">
                <p className="text-slate-900 text-base font-medium leading-tight line-clamp-1">X光胸片上传成功</p>
                <p className="text-slate-500 text-sm font-normal leading-normal line-clamp-2">
                  您的影像资料已上传至云端档案，AI正在进行初步筛查。
                </p>
              </div>
            </div>
            <div className="shrink-0 flex flex-col items-end gap-1">
              <p className="text-gray-400 text-xs font-medium leading-normal">昨天</p>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Notifications;