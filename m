Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E35C433EF
	for <linux-pwm@archiver.kernel.org>; Thu,  7 Apr 2022 07:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbiDGHla (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 7 Apr 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbiDGHl0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Apr 2022 03:41:26 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389193A183;
        Thu,  7 Apr 2022 00:39:16 -0700 (PDT)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1649316786;
        bh=m7FmN16Crg0ON5yyzvdf4vfS/4Bi4srvHiA53HG7nKk=;
        h=From:To:Cc:Subject;
        b=iLlrC08FQrZURBEXBxuxsctKfPsLtw0NEAQSnysya9hcol1eaWwF/0EsVZrxAddhl
         YZWuJJ/ATMTy5RX4XuCpGSdgvu9YG00u47DuFZKwUbAPq4ROe++cR8qA/3HrAfkPp0
         1KuYHvFUs1a90SZW3262zHZZMfzG0g58nFm+Ktg/cQl6rFyQzziX4ftgF5yaQh+LiI
         kWvDCDSMUf2GxRRLggp4Co/g/BPke4orZUC4e9rRRG+YsC2EXIHzD+wxkdYiCOaJvl
         RKSmHXdj4ET4rJwyv70ft7AYnS2vplDmnH6xfthdlhzSsIjTd69k6/cnvLcnBaQtZx
         OIYK51m+CaHFg==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 0/3 RESEND] Multicolor PWM LED support
Date:   Thu,  7 Apr 2022 09:32:22 +0200
Message-Id: <20220407073225.71605-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

Hi,

I believe this patch series is ready for merging.

Pavel, please let me know if you need more to get this merged.

Best regards,
Sven

Sven Schwermer (3):
  dt-bindings: leds: Optional multi-led unit address
  dt-bindings: leds: Add multicolor PWM LED bindings
  leds: Add PWM multicolor driver

 .../bindings/leds/leds-class-multicolor.yaml  |   2 +-
 .../bindings/leds/leds-pwm-multicolor.yaml    |  79 ++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 186 ++++++++++++++++++
 5 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

-- 
2.35.1

