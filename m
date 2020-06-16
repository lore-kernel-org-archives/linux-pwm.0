From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] pwm: iqs620a: Use 64-bit division
Date: Tue, 16 Jun 2020 08:06:54 +0100
Message-ID: <20200616070654.GC2608702@dell>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFPHG6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Jun 2020 03:06:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9DC03E96A
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so402470wrs.11
        for <linux-pwm@vger.kernel.org>; Tue, 16 Jun 2020 00:06:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200615141606.2814208-3-thierry.reding@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Thierry Reding wrote:

> The PWM framework is going to change the PWM period and duty cycles to
> be 64-bit unsigned integers. To avoid build errors on platforms that do
> not natively support 64-bit division, use explicity 64-bit division.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/pwm/pwm-iqs620a.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
