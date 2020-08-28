Return-Path: <SRS0=b+St=CG=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2271FC433E6
	for <linux-pwm@archiver.kernel.org>; Fri, 28 Aug 2020 12:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A9002086A
	for <linux-pwm@archiver.kernel.org>; Fri, 28 Aug 2020 12:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgH1MOm (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:14:42 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:52826 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbgH1MOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 08:14:33 -0400
Received: from erd988.prtnl (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id E953B44ACC14;
        Fri, 28 Aug 2020 14:14:29 +0200 (CEST)
From:   David Jander <david@protonic.nl>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2 0/3] pwm: pwm-pca9685 Disable unused alternative addresses
Date:   Fri, 28 Aug 2020 14:14:12 +0200
Message-Id: <20200828121415.1292388-1-david@protonic.nl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

changes since v2:
- Extra patch: Make comments more consisent
- Extra patch: Use BIT() macro instead of shift
- Fix typo in commit message

David Jander (3):
  drivers: pwm: pwm-pcs9685.c: Make comments more consistent
  drivers: pwm: pwm-pca9685.c: Use BIT() macro instead of shift
  drivers: pwm: pwm-pca9685.c: Disable unused alternative addresses

 drivers/pwm/pwm-pca9685.c | 45 +++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

-- 
2.25.1

