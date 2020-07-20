From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v5 14/19] backlight: cr_bllcd: introduce gpio-backlight
 semantics
Date: Mon, 20 Jul 2020 09:48:22 +0100
Message-ID: <20200720084822.wt5guzetkrgbgdcc@holly.lan>
References: <20200719080743.8560-1-sam@ravnborg.org>
 <20200719080743.8560-15-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTIsb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2020 04:48:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18653C061794
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 01:48:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so24296716wmi.4
        for <linux-pwm@vger.kernel.org>; Mon, 20 Jul 2020 01:48:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200719080743.8560-15-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Sun, Jul 19, 2020 at 10:07:38AM +0200, Sam Ravnborg wrote:
> cr_bllcd can turn backlight ON or OFF.
> Fix semantitics so they equals what we know from gpio-backlight.
> brightness == 0   => backlight off
> brightness == 1   => backlight on
> 
> Use the backlight_get_brightness() helper to simplify the code.
> 
> v2:
>   - reworked to introduce gpio-backlight semantics (Daniel)

Wasn't this added for v5? However, I spotted this change amoung the
other patches so no worries...


> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
