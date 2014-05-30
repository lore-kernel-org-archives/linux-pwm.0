From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 0/2] backlight: remove trivial get_brightness implementations
Date: Fri, 30 May 2014 12:10:48 +0200
Message-ID: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yijing Wang <wangyijing@huawei.com>, Matthew Garrett <matthew.garrett@nebula.com>, Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, Mikulas Patocka <mpato>
List-Id: linux-pwm@vger.kernel.org

This patchset makes get_brightness callback optional
and removes trivial implementations.
Driver changes are quite obvious so I have put them into single
patch.

The patchset is based on the current linux-next branch.

Regards
Andrzej

Andrzej Hajda (2):
  backlight: show brightness even if get_brightness is not implemented
  backlight: remove trivial get_brightness implementations

 drivers/macintosh/via-pmu-backlight.c      | 6 ------
 drivers/platform/x86/samsung-q10.c         | 6 ------
 drivers/video/backlight/aat2870_bl.c       | 6 ------
 drivers/video/backlight/ams369fg06.c       | 6 ------
 drivers/video/backlight/backlight.c        | 2 ++
 drivers/video/backlight/bd6107.c           | 6 ------
 drivers/video/backlight/gpio_backlight.c   | 6 ------
 drivers/video/backlight/ld9040.c           | 6 ------
 drivers/video/backlight/lp855x_bl.c        | 6 ------
 drivers/video/backlight/lp8788_bl.c        | 6 ------
 drivers/video/backlight/lv5207lp.c         | 6 ------
 drivers/video/backlight/pandora_bl.c       | 6 ------
 drivers/video/backlight/pwm_bl.c           | 6 ------
 drivers/video/backlight/s6e63m0.c          | 6 ------
 drivers/video/backlight/tps65217_bl.c      | 6 ------
 drivers/video/fbdev/aty/aty128fb.c         | 6 ------
 drivers/video/fbdev/aty/atyfb_base.c       | 6 ------
 drivers/video/fbdev/aty/radeon_backlight.c | 6 ------
 drivers/video/fbdev/exynos/s6e8ax0.c       | 6 ------
 drivers/video/fbdev/nvidia/nv_backlight.c  | 6 ------
 drivers/video/fbdev/riva/fbdev.c           | 6 ------
 21 files changed, 2 insertions(+), 120 deletions(-)

-- 
1.9.1
