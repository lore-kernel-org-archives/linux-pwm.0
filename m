From: Rajkumar Rampelli <rrajk@nvidia.com>
Subject: [PATCH V2 9/9] arm64: defconfig: enable pwm-fan as a loadable module
Date: Wed, 21 Mar 2018 10:10:44 +0530
Message-ID: <1521607244-29734-10-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com, rrajk@nvidia.com
List-Id: linux-pwm@vger.kernel.org

Enable pwm-fan driver to make use of a PWM interface to
read speed of a fan in rotations per minute.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Added pwm-fan driver support as a loadable module.
    Removed generic-pwm-tachometer driver support which was added as part of v1

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8b2bda7..50aa3bce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -320,6 +320,7 @@ CONFIG_SYSCON_REBOOT_MODE=y
 CONFIG_BATTERY_BQ27XXX=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_LM90=m
+CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
-- 
2.1.4
