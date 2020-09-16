Return-Path: <SRS0=vnaE=CZ=vger.kernel.org=linux-pwm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A2C43461
	for <linux-pwm@archiver.kernel.org>; Wed, 16 Sep 2020 02:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B91E20809
	for <linux-pwm@archiver.kernel.org>; Wed, 16 Sep 2020 02:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgIPC2g (ORCPT <rfc822;linux-pwm@archiver.kernel.org>);
        Tue, 15 Sep 2020 22:28:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbgIPC2C (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3B3D2119396917439775;
        Wed, 16 Sep 2020 10:27:59 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:52 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] pwm: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:28 +0800
Message-ID: <20200916025028.3992887-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/pwm/core.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 276e939a5684..1f16f5365d3c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1327,30 +1327,19 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static const struct seq_operations pwm_seq_ops = {
+static const struct seq_operations pwm_debugfs_sops = {
 	.start = pwm_seq_start,
 	.next = pwm_seq_next,
 	.stop = pwm_seq_stop,
 	.show = pwm_seq_show,
 };
 
-static int pwm_seq_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &pwm_seq_ops);
-}
-
-static const struct file_operations pwm_debugfs_ops = {
-	.owner = THIS_MODULE,
-	.open = pwm_seq_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(pwm_debugfs);
 
 static int __init pwm_debugfs_init(void)
 {
 	debugfs_create_file("pwm", S_IFREG | S_IRUGO, NULL, NULL,
-			    &pwm_debugfs_ops);
+			    &pwm_debugfs_fops);
 
 	return 0;
 }
-- 
2.25.1

