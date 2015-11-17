From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH v5] pwm:lpss: update pwm setting for Broxton
Date: Tue, 17 Nov 2015 09:52:14 +0200
Message-ID: <20151117075214.GD1604@lahna.fi.intel.com>
References: <1447752015-55339-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37591 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbbKQHwX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 17 Nov 2015 02:52:23 -0500
Content-Disposition: inline
In-Reply-To: <1447752015-55339-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, thierry.reding@gmail.com

On Tue, Nov 17, 2015 at 05:20:15PM +0800, Qipeng Zha wrote:
> For Broxton PWM controller, base unit is defined as 8bit integer
> and 14bit fraction, so need to update base unit setting to output
> wave with right frequency.
> 
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>

My ack still applies to this patch.
