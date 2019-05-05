From: Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 0/2] add dsi pwm0 node for mt8183
Date: Sun, 5 May 2019 19:05:15 +0800
Message-ID: <20190505110517.965-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Thierry Reding <treding@nvidia.com>, Ajay Kumar <ajaykumar.rs@samsung.com>, Inki Dae <inki.dae@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sean Paul <seanpaul@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com, cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com, ck.hu@mediate
List-Id: linux-pwm@vger.kernel.org

Changes since v1:
 - remove "mediatek,mt8173-dsi" from dsi node.

This patch is based on v5.1-rc1 and these patches:
http://lists.infradead.org/pipermail/linux-mediatek/2019-March/017963.html
https://patchwork.kernel.org/patch/10856987/
https://patchwork.kernel.org/cover/10879001/
https://patchwork.kernel.org/cover/10846677/
https://patchwork.kernel.org/patch/10893519/

Jitao Shi (2):
  arm64: dts: mt8183: add dsi node
  arm64: dts: mt8183: add pwm0 node

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.21.0
