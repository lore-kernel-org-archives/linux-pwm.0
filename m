Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD46C001DB
	for <linux-pwm@archiver.kernel.org>; Thu, 10 Aug 2023 07:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHJHnn (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Thu, 10 Aug 2023 03:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjHJHnh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Aug 2023 03:43:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EC213B
        for <linux-pwm@vger.kernel.org>; Thu, 10 Aug 2023 00:43:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLzNH42vPztSBy;
        Thu, 10 Aug 2023 15:39:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 15:43:29 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <claudiu.beznea@tuxon.dev>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] pwm: Remove redundant of_match_ptr() macro
Date:   Thu, 10 Aug 2023 15:42:56 +0800
Message-ID: <20230810074258.2390629-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since these pwm drivers depend on CONFIG_OF, there is
no need to wrap the macro of_match_ptr() here.

Ruan Jinjie (2):
  pwm: atmel: Remove redundant of_match_ptr()
  pwm: omap-dmtimer: Remove redundant of_match_ptr()

 drivers/pwm/pwm-atmel.c        | 2 +-
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

