From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 11/14] regulator: pwm: properly initialize the ->state
 field
Date: Fri, 3 Jun 2016 13:51:17 -0700
Message-ID: <20160603205117.GI124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-12-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34297 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161084AbcFCUvV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jun 2016 16:51:21 -0400
Received: by mail-pa0-f45.google.com with SMTP id bz2so17423211pad.1
        for <linux-pwm@vger.kernel.org>; Fri, 03 Jun 2016 13:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464942192-25967-12-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <milo.kim@ti.com>, Doug Anderson <dianders@google.com>, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>, Ajit Pal Singh <ajitpal.singh@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, kernel@stlinux.com

On Fri, Jun 03, 2016 at 10:23:09AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.
> If possible, retrieve the current voltage selector from the PWM state, else
> return -EINVAL.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Heiko, Mark,
> 
> I know you already added your Tested-by/Acked-by tags on this patch
> but this version has slightly change and is now making use of the
> pwm_get_relative_duty_cycle() helper instead of manually converting
> the absolute duty_cycle value into a relative one.
> ---
>  drivers/regulator/pwm-regulator.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Tested-by: Brian Norris <briannorris@chromium.org>
