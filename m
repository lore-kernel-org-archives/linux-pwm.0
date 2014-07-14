From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 05/11] ARM: multi_v7_defconfig: Enable ST's PWM driver
Date: Mon, 14 Jul 2014 15:33:26 +0100
Message-ID: <1405348412-7352-6-git-send-email-lee.jones@linaro.org>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, ajitpal.singh@st.com, thierry.reding@gmail.com, lee.jones@linaro.org
List-Id: linux-pwm@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index be1a345..4b9c96e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -366,6 +366,7 @@ CONFIG_AK8975=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
+CONFIG_PWM_STI=y
 CONFIG_OMAP_USB2=y
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_EXT4_FS=y
-- 
1.8.3.2
