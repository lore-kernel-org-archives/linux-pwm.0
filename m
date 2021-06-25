Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5352C2B9F4
	for <linux-pwm@archiver.kernel.org>; Fri, 25 Jun 2021 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2EB61419
	for <linux-pwm@archiver.kernel.org>; Fri, 25 Jun 2021 08:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFYImG (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 25 Jun 2021 04:42:06 -0400
Received: from mail.thorsis.com ([92.198.35.195]:44139 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFYImF (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Jun 2021 04:42:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id C61C23593;
        Fri, 25 Jun 2021 10:39:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1foNQkjRn8tw; Fri, 25 Jun 2021 10:39:43 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 4118435C5; Fri, 25 Jun 2021 10:39:42 +0200 (CEST)
Date:   Fri, 25 Jun 2021 10:39:32 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <YNWWRM+6p/lgJ28W@ada.ifak-system.com>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
References: <20210623035039.772660-1-bjorn.andersson@linaro.org>
 <20210625011932.6354e397@thinkpad>
 <YNUY9ncs34E6aJMe@yoga>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNUY9ncs34E6aJMe@yoga>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Bjorn,

Am Thu, Jun 24, 2021 at 06:44:54PM -0500 schrieb Bjorn Andersson:
> On Thu 24 Jun 18:19 CDT 2021, Marek Behun wrote:
> > please don't use in new bindings in examples.
> > Instead use color, function and function-enumerator, i.e.
> > 
> >   color = <LED_COLOR_ID_GREEN>;
> >   function = LED_FUNCTION_xxx;
> >   function-enumerator = <N>;
> > 
> 
> Can you point me to something helping me regarding what "function" to
> use?
> 
> For this particular devboard that the example comes from I have 4 LEDs
> that are named "user1", "user2", "user3" and "user4" in the board
> documentation. I can make up whatever for the example, but I would like
> to get the following dts additions follow the expected guidelines.

I asked myself the same question in the past.  The wohle list is in
'include/dt-bindings/leds/common.h' and I in my personal project I
opted for LED_FUNCTION_INDICATOR, but yes, the confusion is real.

Greets
Alex

