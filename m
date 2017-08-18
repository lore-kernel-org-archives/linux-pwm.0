From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 0/2] Add ZTE ZX PWM device driver support
Date: Fri, 18 Aug 2017 20:50:41 +0800
Message-ID: <20170818125039.GL7608@dragon>
References: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdHRMwZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 18 Aug 2017 08:52:25 -0400
Content-Disposition: inline
In-Reply-To: <1501143817-15843-1-git-send-email-shawnguo@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Baoyou Xie <xie.baoyou@sanechips.com.cn>, Xin Zhou <zhou.xin8@sanechips.com.cn>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

On Thu, Jul 27, 2017 at 04:23:35PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The series adds the dt-bindings document and device driver for PWM
> controller found on ZTE ZX family SoCs.
> 
> Changes for v2:
>  - Add Rob's ACK for dt-bindings patch
>  - Use inline function rather than macro for to_zx_pwm_chip()
>  - Convert zx_pwm_ops to implement atomic callbacks .apply() and .get_state()
> 
> Shawn Guo (2):
>   dt-bindings: pwm: add bindings doc for ZTE ZX PWM controller
>   pwm: add ZTE ZX PWM device driver

Hi Thierry,

We are getting close to 4.14 merge window.  Do you have any comments on
the series?

Shawn
