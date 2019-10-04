From: Yizhuo Zhai <yzhai003@ucr.edu>
Subject: Potential uninitialized variables in pwm: stm32-lp
Date: Thu, 3 Oct 2019 21:52:31 -0700
Message-ID: <CABvMjLSR9kFJpU19OX8Us4jPQ9vuTtNR571Njn_gqqpb-=hdCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>, Chengyu Song <csong@cs.ucr.edu>
List-Id: linux-pwm@vger.kernel.org

Hi All:

drivers/pwm/pwm-stm32-lp.c:

Variable "val" and "prd" in function stm32_pwm_lp_get_state() could be
uninitialized
if regmap_read() returns -EINVAL. But it's directly used later without
the return check,
which is potentially unsafe.

Also, we cannot simply return -EINVAL in stm32_pwm_lp_get_state() because the
return type is void.

Thanks for your time to check this case.
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
