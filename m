From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 17/20] backlight: use backligt_get_brightness()
Date: Wed, 8 Jul 2020 12:14:30 +0100
Message-ID: <20200708111430.rkcnqla77hds6wg2@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-18-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGHLOe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 07:14:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F84C08E6DC
        for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2020 04:14:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so2534900wmh.2
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2020 04:14:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-18-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Fri, Jul 03, 2020 at 08:45:43PM +0200, Sam Ravnborg wrote:
> Introduce the backlight_get_brightness() helper in all
> video/backlight/* drivers.
> This simplifies the code and align the implementation of the
> update_status() operation across the different backlight drivers.
> 
> Some of the drivers gains a little extra functionality by the change
> as they now respect the fb_blank() ioctl.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
