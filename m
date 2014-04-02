From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/2] pwm: tiehrpwm: inline accessor functions
Date: Wed,  2 Apr 2014 13:56:22 +0200
Message-ID: <1396439802-6813-2-git-send-email-wsa@the-dreams.de>
References: <1396439802-6813-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51355 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758442AbaDBL5A (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 2 Apr 2014 07:57:00 -0400
In-Reply-To: <1396439802-6813-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Wolfram Sang <wsa@sang-engineering.com>, Thierry Reding <thierry.reding@gmail.com>

From: Wolfram Sang <wsa@sang-engineering.com>

These elementary functions should be inlined for fastest access. Also
fixes this warning as a side-effect (when no PM_SLEEP is selected):

drivers/pwm/pwm-tiehrpwm.c:141:12: warning: 'ehrpwm_read' defined but not used [-Wunused-function]

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b2544296430a..232a4be11e67 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -138,12 +138,12 @@ static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct ehrpwm_pwm_chip, chip);
 }
 
-static u16 ehrpwm_read(void __iomem *base, int offset)
+static inline u16 ehrpwm_read(void __iomem *base, int offset)
 {
 	return readw(base + offset);
 }
 
-static void ehrpwm_write(void __iomem *base, int offset, unsigned int val)
+static inline void ehrpwm_write(void __iomem *base, int offset, unsigned int val)
 {
 	writew(val & 0xFFFF, base + offset);
 }
-- 
1.9.0

