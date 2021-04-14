Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95439C433ED
	for <linux-pwm@archiver.kernel.org>; Wed, 14 Apr 2021 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0A61249
	for <linux-pwm@archiver.kernel.org>; Wed, 14 Apr 2021 10:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhDNKuA (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:50:00 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:28499 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhDNKt6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Apr 2021 06:49:58 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 13EAd1Si057543;
        Wed, 14 Apr 2021 18:39:01 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Apr
 2021 18:49:31 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 0/2] Support pwm driver for aspeed ast26xx
Date:   Wed, 14 Apr 2021 18:49:37 +0800
Message-ID: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 13EAd1Si057543
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The legacy driver of aspeed pwm is binding with tach controller and it
doesn't follow the pwm framworks usage. In addition, the pwm register
usage of the 6th generation of ast26xx has drastic change. So these
patch serials add the new aspeed pwm driver to fix up the problem above.

Changes since v1:
- Fix the dt_binding_check fail suggested by Rob Herring
- Add depends to PWM_ASPEED_G6 configure suggested by Uwe Kleine-Konig
- pwm-aspeed-g6.c suggested by Uwe Kleine-König
  - Fix license header
  - Use bitfiled.h macro to define register fields
  - Implement .remove device function
  - Implement .get_state pwm api

Billy Tsai (2):
  dt-bindings: Add bindings for aspeed pwm-tach and pwm.
  pwm: Add Aspeed ast2600 PWM support

 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  60 ++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  44 +++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-g6.c                   | 324 ++++++++++++++++++
 5 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/pwm/pwm-aspeed-g6.c

-- 
2.25.1

