From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/5] clk: ti: am335x/am4372: Add tbclk to pwm node
Date: Fri, 15 Apr 2016 17:46:54 -0700
Message-ID: <20160416004654.GP26353@codeaurora.org>
References: <1457380318-15452-1-git-send-email-fcooper@ti.com>
 <1457380318-15452-2-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41094 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcDPAq6 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 20:46:58 -0400
Content-Disposition: inline
In-Reply-To: <1457380318-15452-2-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, t-kristo@ti.com, mturquette@baylibre.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org

On 03/07, Franklin S Cooper Jr wrote:
> Add tblck to the pwm nodes. This insures that the ehrpwm driver has access
> to the time-based clk.
> 
> Do not remove similar entries for ehrpwm node. Later patches will switch
> from using ehrpwm node name to pwm. But to maintain ABI compatibility we
> shouldn't remove the old entries.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
