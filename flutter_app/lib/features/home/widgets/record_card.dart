import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/record.dart';

class RecordCard extends StatelessWidget {
  final Record record;
  final VoidCallback? onTap;

  const RecordCard({
    super.key,
    required this.record,
    this.onTap,
  });

  Color get _statusColor {
    switch (record.status) {
      case RecordStatus.completed:
        return AppColors.success;
      case RecordStatus.processing:
        return AppColors.warning;
      case RecordStatus.attention:
        return AppColors.warning;
      case RecordStatus.normal:
        return AppColors.success;
    }
  }

  Color get _statusBgColor {
    switch (record.status) {
      case RecordStatus.completed:
        return AppColors.success.withOpacity(0.1);
      case RecordStatus.processing:
        return AppColors.warning.withOpacity(0.1);
      case RecordStatus.attention:
        return AppColors.warning.withOpacity(0.1);
      case RecordStatus.normal:
        return AppColors.success.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Row(
          children: [
            // Thumbnail
            _buildThumbnail(),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          record.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusBadge(),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.type,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    record.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Chevron
            const Icon(
              CupertinoIcons.chevron_right,
              size: 18,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (record.thumbnail != null) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(record.thumbnail!),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(
          CupertinoIcons.heart_fill,
          size: 28,
          color: AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _statusBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        record.statusLabel,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _statusColor,
        ),
      ),
    );
  }
}
