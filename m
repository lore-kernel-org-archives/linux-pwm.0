From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with
 COMPILE_TEST
Date: Fri, 18 May 2018 17:24:03 +0200
Message-ID: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lee.jones@linaro.org, thierry.reding@gmail.com
Cc: sfr@canb.auug.org.au, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, mcoquelin.stm32@gmail.com, gerald.baeza@st.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 include/linux/mfd/stm32-timers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 9da1d7e..067d146 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -124,8 +124,20 @@ struct stm32_timers {
 	struct stm32_timers_dma dma; /* Only to be used by the parent */
 };
 
+#if IS_REACHABLE(CONFIG_MFD_STM32_TIMERS)
 int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
 				enum stm32_timers_dmas id, u32 reg,
 				unsigned int num_reg, unsigned int bursts,
 				unsigned long tmo_ms);
+#else
+static inline int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
+					      enum stm32_timers_dmas id,
+					      u32 reg,
+					      unsigned int num_reg,
+					      unsigned int bursts,
+					      unsigned long tmo_ms)
+{
+	return -ENODEV;
+}
+#endif
 #endif
-- 
1.9.1
