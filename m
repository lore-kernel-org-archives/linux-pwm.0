Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03175C87FDE
	for <linux-pwm@archiver.kernel.org>; Thu,  8 Jun 2023 15:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjFHPvn (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 8 Jun 2023 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbjFHPvl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jun 2023 11:51:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC1730D3;
        Thu,  8 Jun 2023 08:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03FFB61EDA;
        Thu,  8 Jun 2023 15:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6D0C433EF;
        Thu,  8 Jun 2023 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239458;
        bh=AQ6hR3FzA39YWv7fHa7/a1etUE1gUTycGOqZra1Bjwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLU1X4hdYhUkVxzpTAb17ez2F1tMW0Zd7Y9jQdqBR1p1xjXd2UyXOI5rvwfRR9Iqo
         piKOSm5ZBrdeWRXIw44MR464pFo8P5qJCP3hjo7imsKBpjsD3j66BpwhiDoTOd5g99
         Ux3sF8ugQFlwlCyfOy7D+utESHxwu4kZCykPVasDyeLx9Ma9ONVyE3hfRwKvZinrRe
         diei8P4/N0un6y8mtdSg3S7fHYl7a3zPx9XRi0yo30Tc6pDfModkOrUVoo79dHx5aC
         eqXzDQak9ZwaU4Ucm+fiO5Msquz5KBnFkahchdmaeTohhBTTMa2NXlyGW6uHEUI045
         B4HzGBskHnOQA==
Date:   Thu, 8 Jun 2023 16:50:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/4] video: backlight: lp855x: get PWM for PWM mode
 during probe
Message-ID: <20230608155051.GR1930705@google.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
 <20230519180728.2281-3-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519180728.2281-3-aweber.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 19 May 2023, Artur Weber wrote:

> Also deprecate the pwm-period DT property, as it is now redundant
> (pwms property already contains period value).
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  drivers/video/backlight/lp855x_bl.c | 48 ++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 22 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
