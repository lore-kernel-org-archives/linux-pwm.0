Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:41432 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbfFMKE7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 06:04:59 -0400
Date: Thu, 13 Jun 2019 12:04:54 +0200
From: Simon Horman <horms@verge.net.au>
Message-ID: <20190613100453.ythhx3lika5cil4q@verge.net.au>
References: <1559296501-30620-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559296501-30620-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559296501-30620-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v3 1/4] pwm: Add power management descriptions
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Fri, May 31, 2019 at 06:54:58PM +0900, Yoshihiro Shimoda wrote:
> This patch adds power management descriptions that consumers should
> implement it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/pwm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/pwm.txt b/Documentation/pwm.txt
> index 8fbf0aa..ab62f1b 100644
> --- a/Documentation/pwm.txt
> +++ b/Documentation/pwm.txt
> @@ -65,6 +65,10 @@ period). struct pwm_args contains 2 fields (period and polarity) and should
>  be used to set the initial PWM config (usually done in the probe function
>  of the PWM user). PWM arguments are retrieved with pwm_get_args().
>  
> +All consumers should really be reconfiguring the PWM upon resume as
> +appropriate. This is the only way to ensure that everything is resumed in
> +the proper order.
> +
>  Using PWMs with the sysfs interface
>  -----------------------------------
>  
> @@ -141,6 +145,9 @@ The implementation of ->get_state() (a method used to retrieve initial PWM
>  state) is also encouraged for the same reason: letting the PWM user know
>  about the current PWM state would allow him to avoid glitches.
>  
> +Drivers should not implement any power management. In other words,
> +consumers should implement it as described in the "Using PWMs" section.
> +
>  Locking
>  -------
>  
> -- 
> 2.7.4
> 
