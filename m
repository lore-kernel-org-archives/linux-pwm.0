From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESEND PATCH v2 2/5] backlight: pwm_bl: Add device link for pwm_bl and pwm
Date: Mon, 16 Oct 2017 18:06:37 +0800
Message-ID: <20171016100640.26575-3-jeffy.chen@rock-chips.com>
References: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, heiko@sntech.de, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

When the pwm driver is unbound, the pwm_bl driver would still hold a
reference to that pwm, and crash the kernel later(if someone trying
to access that invalid pwm).

Add a device link to avoid this.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/video/backlight/pwm_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9bd17682655a..a76f147a26e7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -328,6 +328,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	device_link_add(&pdev->dev, pb->pwm->chip->dev, DL_FLAG_AUTOREMOVE);
+
 	dev_dbg(&pdev->dev, "got pwm for backlight\n");
 
 	/*
-- 
2.11.0
