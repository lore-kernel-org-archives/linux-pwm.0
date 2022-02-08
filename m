Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D87C433F5
	for <linux-pwm@archiver.kernel.org>; Tue,  8 Feb 2022 08:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352215AbiBHIyF (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiBHIyE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Feb 2022 03:54:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58ADC03FEC8
        for <linux-pwm@vger.kernel.org>; Tue,  8 Feb 2022 00:54:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so882217wme.1
        for <linux-pwm@vger.kernel.org>; Tue, 08 Feb 2022 00:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TwOpOhCkewurBTdSPeNG/7ZJDIatq7Dw8T+vkk/TtIs=;
        b=lW/GiqdU3VVDp/fM92/DOGcQiYkmHr49MJ8+ldaZtWG+Rz0AGaKzffcSP6e7mKYNtp
         49/IjQdY63rG2pETJUo630qcGPZsdVPQIJj873h1TvLczfsWYqMZ38inMSLfNaQihw9x
         LhQvvvpv/jIbjn+KTCIi6iLEIN8lvzm/6z25rtRwYmtebnh9Sej2ZI4P16dbsIDlL9mh
         weGZIiRJ4jqQDxuxM3tk44SqZbaAO/aFwlinYdFKoqsb7UiI8wm+hdy5UPdESAp0DOyB
         bO2AMyvRX9Z6EXZ6UNE/DXSiy8BmQ9npowQ8ZGmqcoPgFy3Y+1vOh8MWE6YKaPeRtFOk
         ZR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TwOpOhCkewurBTdSPeNG/7ZJDIatq7Dw8T+vkk/TtIs=;
        b=B+dA16FdmJmVc9nzixCJhOqrD+1fg0TQIZVrIeykt1HKuiHIjyg7OCSSqntqO7dR24
         gqUX5ZbWMW73TE20JH8Z8JPeC8kLpicw29qY3iqe7TkNSu8qtiKDOqdgwCwoxaRao6Gw
         7gRPP390EJDXiPxE6r0+Vn0Co3VsW7Ddrw3hnp40xz6i030pCOJDlK57oVASMaWsH0T7
         49E78byo8fIMjd1pTQzHrO8xd2WMBDYIIHPZjTf1/cI/DT2ezaHxMHieMMCWpFlOsiUd
         c3v0t1zc79hdAMyAiCORv88Gg7+FnWZwCtJbd7UtbyUrNOvYIKUVWQ1ttkdtjVZUkK0B
         OPcw==
X-Gm-Message-State: AOAM533S+Pn6w07Vdp7LMf4ZTxD4Sg2nCTS/6ctZXumq5cekhIfmFgYx
        JPJVn/fwm06jkcAZ1y4DgHXRxA==
X-Google-Smtp-Source: ABdhPJyOewoFyg7DILHZmhtw2fzDp/fVpk8M5K4TsGNIZ1zInW2wlEQgwVzk/ZuITeCHKUQCDC3Q7w==
X-Received: by 2002:a1c:a595:: with SMTP id o143mr191510wme.78.1644310439409;
        Tue, 08 Feb 2022 00:53:59 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o10sm7645041wri.69.2022.02.08.00.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:53:58 -0800 (PST)
Date:   Tue, 8 Feb 2022 08:53:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid open coded arithmetic in memory
 allocation
Message-ID: <YgIvpFp8igFkVsP+@google.com>
References: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd3d74acfa58d59f6f5f81fc5a9fb409edb8d747.1644046817.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 05 Feb 2022, Christophe JAILLET wrote:

> kmalloc_array()/kcalloc() should be used to avoid potential overflow when
> a multiplication is needed to compute the size of the requested memory.
> 
> So turn a kzalloc()+explicit size computation into an equivalent kcalloc().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
