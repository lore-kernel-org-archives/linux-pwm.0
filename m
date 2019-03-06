From: Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 6/7] counter: ftm-quaddec: Documentation: Add specific counter sysfs documentation
Date: Wed,  6 Mar 2019 12:12:07 +0100
Message-ID: <20190306111208.7454-7-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
List-Id: linux-pwm@vger.kernel.org

This adds documentation for the specific prescaler entry.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
---
Changes v2
 - Add doc for prescaler entry
---
 .../ABI/testing/sysfs-bus-counter-ftm-quaddec    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
new file mode 100644
index 000000000000..2da629d6d485
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
@@ -0,0 +1,16 @@
+What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Discrete set of available values for the respective Count Y
+		configuration are listed in this file. Values are delimited by
+		newline characters.
+
+What:		/sys/bus/counter/devices/counterX/countY/prescaler
+KernelVersion:	5.1
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Configure the prescaler value associated with Count Y.
+		On the FlexTimer, the counter clock source passes through a
+		prescaler that is a 7-bit counter. This acts like a clock
+		divider.
-- 
2.19.1
