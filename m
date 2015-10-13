From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v2] pwm: lpss: add PM support for LPSS PWM
Date: Tue, 13 Oct 2015 16:55:10 +0300
Message-ID: <20151013135510.GR1492@lahna.fi.intel.com>
References: <1444381373-17791-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60833 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbbJMNzO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 13 Oct 2015 09:55:14 -0400
Content-Disposition: inline
In-Reply-To: <1444381373-17791-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, Huiquan Zhong <huiquan.zhong@intel.com>

On Fri, Oct 09, 2015 at 05:02:53PM +0800, Qipeng Zha wrote:
> +const struct dev_pm_ops pwm_lpss_pm = {
> +	.suspend_late = pwm_lpss_suspend,
> +	SET_RUNTIME_PM_OPS(pwm_lpss_suspend, NULL, NULL)
> +};
> +EXPORT_SYMBOL(pwm_lpss_pm);

_GPL() please.
