From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Date: Sun, 24 Mar 2019 23:02:16 +0100
Message-ID: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Martin Blumenstingl <martin.blumenstingl@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

Back in January a "BUG: scheduling while atomic" error showed up during
boot on my Meson8b Odroid-C1 (which uses a PWM regulator as CPU supply).
The call trace comes down to:
  __mutex_lock
  clk_prepare_lock
  clk_core_get_rate
  meson_pwm_apply
  ..
  dev_pm_opp_set_rate
  ..

Jerome has also seen the same problem but from pwm-leds (instead of a
pwm-regulator). He posted a patch which replaces the spinlock with a
mutex. That works. I believe we can optimize this by reducing the time
where the lock is held - that also allows to keep the spin-lock.

Analyzing this issue helped me understand the pwm-meson driver better.
My plan is to send some cleanups (with the goal of re-using more of the
goodies from the PWM core in the pwm-meson driver) after this single fix
is merged (they can be found here: [1]).

Dependencies: none

Target version: please queue this for -fixes so it makes it's way into
v5.1-rc (so we can get it backported from there, because this issue has
existed since the pwm-meson driver was introduced).


[0] http://lists.infradead.org/pipermail/linux-amlogic/2019-January/009690.html
[1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v0


Martin Blumenstingl (1):
  pwm: meson: use the spin-lock only to protect register modifications

 drivers/pwm/pwm-meson.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.21.0
