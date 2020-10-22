Return-Path: <SRS0=p4Yd=D5=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2600CC388F7
	for <linux-pwm@archiver.kernel.org>; Thu, 22 Oct 2020 19:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28D72465A
	for <linux-pwm@archiver.kernel.org>; Thu, 22 Oct 2020 19:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="jFyZz9aL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="qOGdj963"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370184AbgJVTZi (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 22 Oct 2020 15:25:38 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:56162 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370187AbgJVTZh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 15:25:37 -0400
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 7DD85C7218; Thu, 22 Oct 2020 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1603394734; bh=AFNcYWN73jXXlPkynUL1liT45MKc2/cfgOevOqrJe2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jFyZz9aLvJfIjb3HAGm7dQFw6S49OGVQwJGZm2EVINeXUKCAZXRXs3Ps79kPq8TWZ
         kqwjhpOlg2fWiWJBDcQ1jkpskQHOCLv2d9b5p+fklGrR/uEjMYpyh1QEXbaqvPOF1x
         vBDolVSKGVoKZtGSR8kD0xd2mfffLeLM3P62pldY=
Received: from g550jk.localnet (80-110-125-173.cgn.dynamic.surfer.at [80.110.125.173])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 45380C669B;
        Thu, 22 Oct 2020 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1603394732; bh=AFNcYWN73jXXlPkynUL1liT45MKc2/cfgOevOqrJe2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qOGdj963fPa7D28jT90vH01qDZdMKfXkWrKzTnfvFQKODGxLTncuwHeX0wintU3yz
         5jbmpTgkEQJhtbJyiCYyQZ0L4sAWnena+v+J4EhSyQE124ZoItW4fBiPPu/AOgCRXD
         6JvaCLuQ/lFecpHws0Bvk1g1cZ1toEy/N9A51lME=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Date:   Thu, 22 Oct 2020 21:25:31 +0200
Message-ID: <7499087.fvuViRk2k7@g550jk>
In-Reply-To: <20201021201224.3430546-3-bjorn.andersson@linaro.org>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org> <20201021201224.3430546-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On Mittwoch, 21. Oktober 2020 22:12:22 CEST Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. It can operate on fixed parameters or based on a
> lookup-table, altering the duty cycle over time - which provides the
> means for e.g. hardware assisted transitions of LED brightness.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v5:
> - Make sure to not used the state of the last channel in a group to
> determine if the current sink should be active for all channels in the
> group. - Replacement of unsigned -1 with UINT_MAX
> - Work around potential overflow by using larger data types, instead of
> separate code paths - Use cpu_to_l16() rather than hand rolling them
> - Minor style cleanups
> 
>  drivers/leds/Kconfig         |    9 +
>  drivers/leds/Makefile        |    1 +
>  drivers/leds/leds-qcom-lpg.c | 1190 ++++++++++++++++++++++++++++++++++
>  3 files changed, 1200 insertions(+)
>  create mode 100644 drivers/leds/leds-qcom-lpg.c

Tested on msm8974 (pm8941) on the Fairphone 2, works great there!

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca


