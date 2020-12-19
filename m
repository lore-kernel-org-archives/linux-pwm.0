Return-Path: <linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD467C0018C
	for <linux-pwm@archiver.kernel.org>; Sat, 19 Dec 2020 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADC022D72
	for <linux-pwm@archiver.kernel.org>; Sat, 19 Dec 2020 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgLSUpL (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Sat, 19 Dec 2020 15:45:11 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:32944 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgLSUpL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 19 Dec 2020 15:45:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 1016DBFD50;
        Sat, 19 Dec 2020 20:44:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 750NSG3Cgy_m; Sat, 19 Dec 2020 20:44:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id D2F66BFBC9;
        Sat, 19 Dec 2020 20:44:16 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v2 0/3] pwm: rockchip: Eliminate potential race condition when probing
Date:   Sat, 19 Dec 2020 15:44:07 -0500
Message-Id: <cover.1608407584.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch series aims to eliminate the race condition Trent Piepho
identified[0] in the Rockchip PWM driver's rockchip_pwm_probe()
function, by moving code that disables a PWM device's signal clock
ahead of the code that registers the device via pwmchip_add().

It additionally

- Fixes a potential kernel hang introduced by my earlier commit
  457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while
  probing") by ensuring a device's APB clock is enabled before its
  registers are accessed, and

- Tries to improve the driver by (re-)enabling the signal clock of
  only PWM devices that appear to have been started already by the
  bootloader, rather than enabling every device's signal clock and
  selectively disabling it later.

I've tested these changes on my (RK3399-based) Pinebook Pro with its
screen backlight enabled by U-Boot and they appear to work fine.

I'd be grateful for help with testing on other devices, particularly
those with SoCs like the RK3328 that use separate bus and signal
clocks for their PWM devices. (My ROCK64 uses its PWM-output pins for
other purposes and wasn't of help here.)

[0] https://www.spinics.net/lists/linux-pwm/msg14611.html

--
Simon South
simon@simonsouth.net


Simon South (3):
  pwm: rockchip: Enable APB clock during register access while probing
  pwm: rockchip: Eliminate potential race condition when probing
  pwm: rockchip: Do not start PWMs not already running

 drivers/pwm/pwm-rockchip.c | 49 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

-- 
2.29.2

