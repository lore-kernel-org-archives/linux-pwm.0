From: Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v10 08/12] pwm: mediatek: Add MT7629 compatible string
Date: Wed, 25 Sep 2019 22:32:33 +0800
Message-ID: <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Sam Shih <sam.shih@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

This adds pwm support for MT7629, and separate mt7629 compatible string
from mt7622

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ce7525d8d71b..7035abfbdc6a 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -307,11 +307,17 @@ static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.pwm45_fixup = true,
 };
 
+static const struct pwm_mediatek_of_data mt7629_pwm_data = {
+	.fallback_npwms = 1,
+	.pwm45_fixup = false,
+};
+
 static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pwm_mediatek_of_match);
-- 
2.17.1
