Return-Path: <SRS0=54Uu=DO=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B0C4727E
	for <linux-pwm@archiver.kernel.org>; Wed,  7 Oct 2020 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA5A20870
	for <linux-pwm@archiver.kernel.org>; Wed,  7 Oct 2020 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="nssfBIoB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="KKS8sIN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgJGJqa (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 7 Oct 2020 05:46:30 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:60252 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgJGJqa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Oct 2020 05:46:30 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 05:46:28 EDT
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 8B5E3C7196; Wed,  7 Oct 2020 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1602063673; bh=G58nxDXR85aKAm9KZdsGVsJleTDCbz79NyrWb3uEyXY=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=nssfBIoByvP+3EH8HJuENhBQuGQTosfme+khCz5ttbYEyLd78Tns6n+r4cV4JfDxm
         wy0lUjTBOkxGZizXrUTo/HZyCgQ6vgOmYd2Dl8Csxx1xkVPJIfCjkc6d4BIqDcVZ0I
         2vy3Z8F7bZoZVY6eeB0nYQ9yX5E59hiF4rGCiHXc=
Received: from localhost (arch-vps [128.199.32.197])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 56ED9C4CF4;
        Wed,  7 Oct 2020 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1602063670; bh=G58nxDXR85aKAm9KZdsGVsJleTDCbz79NyrWb3uEyXY=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=KKS8sIN1+vS6ETBIO+nKA9RcB493ngK2y7IMwGZaazCBBxwrViO4xq7AtWUo/aYjo
         cXV6RfG7Ouk0NCyObeT5ynmMRocAhiuz4TEmukpj+X4BMAbFGCEy0Gmo9iIrzIYpRX
         eOTbzPqkkEVD23ITtVw0Llo5t2J9nm+UyQez7qtQ=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] leds: Add driver for Qualcomm LPG
From:   "Luca Weiss" <luca@z3ntu.xyz>
To:     "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        "Pavel Machek" <pavel@ucw.cz>, "Dan Murphy" <dmurphy@ti.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Martin Botka" <martin.botka1@gmail.com>
Date:   Wed, 07 Oct 2020 09:40:45 +0000
Message-Id: <C66K5YFY5LGN.1S3H72H0QQQAI@arch-vps>
In-Reply-To: <20200929031544.1000204-3-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On Mon Sep 28, 2020 at 8:15 PM, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v3:
> - Adopt multicolor model
> - Simplified hw_pattern implementation
>
> drivers/leds/Kconfig | 9 +
> drivers/leds/Makefile | 1 +
> drivers/leds/leds-qcom-lpg.c | 1213 ++++++++++++++++++++++++++++++++++
> 3 files changed, 1223 insertions(+)
> create mode 100644 drivers/leds/leds-qcom-lpg.c

<snip>

> +static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device
> *pwm)
> +{
> + struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> + struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +
> + return chan->in_use ? -EBUSY : 0;
> +}
> +
> +static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> + const struct pwm_state *state)
> +{
> + struct lpg *lpg =3D container_of(chip, struct lpg, pwm);
> + struct lpg_channel *chan =3D &lpg->channels[pwm->hwpwm];
> +
> + lpg_calc_freq(chan, state->period / NSEC_PER_USEC);
> + lpg_calc_duty(chan, state->duty_cycle / NSEC_PER_USEC);

As written on IRC this has to be wrapped div_u64() to compile on arm32;
should also fix the buildbot failure.

> + chan->enabled =3D state->enabled;
> +
> + lpg_apply(chan);
> +
> + triled_set(lpg, chan->triled_mask, chan->enabled);
> +
> + return 0;
> +}

Other than that, this works great on msm8974-fairphone-fp2 (pm8941)
with reg 7 (red), 6 (green) & 5 (blue). Thanks for updating this
patchset!

Regards
Luca
