From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH] pwm: lpss: add PM support for LPSS PWM
Date: Tue, 15 Sep 2015 11:15:23 +0300
Message-ID: <20150915081523.GG1525@lahna.fi.intel.com>
References: <1442313626-63022-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20084 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752406AbbIOIPa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 15 Sep 2015 04:15:30 -0400
Content-Disposition: inline
In-Reply-To: <1442313626-63022-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com, Huiquan Zhong <huiquan.zhong@intel.com>

On Tue, Sep 15, 2015 at 06:40:26PM +0800, Qipeng Zha wrote:
> Signed-off-by: Huiquan Zhong <huiquan.zhong@intel.com>
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

Can you please write a proper changelog explaining *why* this change is
needed, thanks.

For devices as simple as LPSS PWM I have hard time understanding why it
needs to implement runtime PM.
