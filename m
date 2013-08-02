Return-Path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34682 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab3HBGWG (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Aug 2013 02:22:06 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQW00AUJ4CMZ9E0@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Fri, 02 Aug 2013 15:22:03 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] pwm: pwm-tiehrpwm: add missing __iomem annotation
Date: Fri, 02 Aug 2013 15:22:03 +0900
Message-id: <000f01ce8f48$9a60de60$cf229b20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: 'Thierry Reding' <thierry.reding@avionic-design.de>
Cc: linux-pwm@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Fix the following sparse warnings:

drivers/pwm/pwm-tiehrpwm.c:144:16: warning: incorrect type in argument 1 (different address spaces)
drivers/pwm/pwm-tiehrpwm.c:144:16:    expected void const volatile [noderef] <asn:2>*addr
drivers/pwm/pwm-tiehrpwm.c:144:16:    got void *
drivers/pwm/pwm-tiehrpwm.c:149:9: warning: incorrect type in argument 2 (different address spaces)
drivers/pwm/pwm-tiehrpwm.c:149:9:    expected void volatile [noderef] <asn:2>*addr
drivers/pwm/pwm-tiehrpwm.c:149:9:    got void *
drivers/pwm/pwm-tiehrpwm.c:157:18: warning: incorrect type in argument 1 (different address spaces)
drivers/pwm/pwm-tiehrpwm.c:157:18:    expected void const volatile [noderef] <asn:2>*addr
drivers/pwm/pwm-tiehrpwm.c:157:18:    got void *
drivers/pwm/pwm-tiehrpwm.c:160:9: warning: incorrect type in argument 2 (different address spaces)
drivers/pwm/pwm-tiehrpwm.c:160:9:    expected void volatile [noderef] <asn:2>*addr
drivers/pwm/pwm-tiehrpwm.c:160:9:    got void *

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pwm/pwm-tiehrpwm.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index aa4c558..084f552 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -139,17 +139,17 @@ static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct ehrpwm_pwm_chip, chip);
 }
 
-static u16 ehrpwm_read(void *base, int offset)
+static u16 ehrpwm_read(void __iomem *base, int offset)
 {
 	return readw(base + offset);
 }
 
-static void ehrpwm_write(void *base, int offset, unsigned int val)
+static void ehrpwm_write(void __iomem *base, int offset, unsigned int val)
 {
 	writew(val & 0xFFFF, base + offset);
 }
 
-static void ehrpwm_modify(void *base, int offset,
+static void ehrpwm_modify(void __iomem *base, int offset,
 		unsigned short mask, unsigned short val)
 {
 	unsigned short regval;
-- 
1.7.10.4


