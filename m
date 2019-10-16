From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH 0/1] Convert period and duty cycle to u64
Date: Tue, 15 Oct 2019 19:11:38 -0700
Message-ID: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com, Mark Salyzyn <salyzyn@google.com>, Sandeep Patil <sspatil@google.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Guru Das Srinagesh <gurus@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

Reworked the change pushed upstream earlier [1] so as to not add an extension
to an obsolete API. With this change, pwm_ops->apply() can be used to set
pwm_state parameters as usual.

[1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/

Guru Das Srinagesh (1):
  pwm: Convert period and duty cycle to u64

 drivers/pwm/core.c  |  4 ++--
 drivers/pwm/sysfs.c | 10 +++++-----
 include/linux/pwm.h | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
