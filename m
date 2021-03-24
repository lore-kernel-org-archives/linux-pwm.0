Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B65C433E1
	for <linux-pwm@archiver.kernel.org>; Wed, 24 Mar 2021 15:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F5061A09
	for <linux-pwm@archiver.kernel.org>; Wed, 24 Mar 2021 15:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhCXPVR (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhCXPVG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Mar 2021 11:21:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FBC061763
        for <linux-pwm@vger.kernel.org>; Wed, 24 Mar 2021 08:21:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP5Je-00028j-JD; Wed, 24 Mar 2021 16:21:02 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP5Jc-0003ed-Oa; Wed, 24 Mar 2021 16:21:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pwm@vger.kernel.org
Subject: [PATCH 0/2] Changes for pwmchip_remove()
Date:   Wed, 24 Mar 2021 16:20:56 +0100
Message-Id: <20210324152058.69022-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_remove currently can (theoretically) return an error code and
most drivers check for that and pass an error to the upper layer just to
be ignored there. Before device links were used this resulted in
half-registered drivers that failed to free all allocated resources.
Today it just makes these remove functions more complicated than
necessary.

This series simplifies pwmchip_remove() and prepares a first driver to
eventually make pwmchip_remove() return void.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: Drop unused error path from pwmchip_remove()
  pwm: imx27: Don't check the return code of pwmchip_remove()

 drivers/pwm/core.c      | 16 ++--------------
 drivers/pwm/pwm-imx27.c |  4 +++-
 2 files changed, 5 insertions(+), 15 deletions(-)

-- 
2.30.2

