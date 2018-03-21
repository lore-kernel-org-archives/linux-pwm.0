From: Rajkumar Rampelli <rrajk@nvidia.com>
Subject: [PATCH V2 6/9] arm64: tegra: Add pwm based fan support on Tegra186
Date: Wed, 21 Mar 2018 10:10:41 +0530
Message-ID: <1521607244-29734-7-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, rrajk@nvidia.com, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, ldewangan@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Add pwm fan driver support on Tegra186 SoC.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Removed generic-pwm-tachometer driver dt node and using pwm-fan driver
    for reading fan speed.

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 19e1afc..27ae73e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1053,4 +1053,10 @@
 		reset-names = "tachometer";
 		status = "disabled";
 	};
+
+	pwm_fan {
+		compatible = "pwm-fan";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "disabled";
+	};
 };
-- 
2.1.4
