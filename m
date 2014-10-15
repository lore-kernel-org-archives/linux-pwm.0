From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 0/3] pwm: ftm: add Power Management support
Date: Wed, 15 Oct 2014 13:21:32 +0800
Message-ID: <1413350495-40980-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: linux-pwm@vger.kernel.org

Changes in v2:
- Fix one bug.
- Add regmap cache support.
- Remove run time PM for now.

Xiubo Li (3):
  pwm: ftm: fix one bug of wrong counting the use counter.
  pwm: ftm: add regmap rbtree type cache support.
  pwm: ftm: add Power Management support for FTM pwm.

 drivers/pwm/pwm-fsl-ftm.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

-- 
2.1.0.27.g96db324
