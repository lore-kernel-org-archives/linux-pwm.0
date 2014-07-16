From: Huayi Li <huayi.li@csr.com>
Subject: [PATCH v5 0/4] PWM: add and enable CSR SiRFSoC PWM driver
Date: Wed, 16 Jul 2014 09:55:10 +0800
Message-ID: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
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
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: rongjun.ying@csr.com, Huayi Li <huayi.li@csr.com>, barry.song@csr.com, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Changes in v5:
 - select the best source clock which can be divided to a more
   accurate PWM clock
 - only enable PWM clock and its source clock when needed 


Changes in v3:
 - v4: fix many issues from Thierry's feedbacks

Changes in v3:
 - add "depends on" COMPILE_TEST according to Arnd's feedback;
 - move the pwm clock source to dts according to Arnd's feedback;
 - add lost dt-binding document

Changes in v2:
 - clean the source clock of PWM wave, use OSC(26MHz)

Huayi Li (4):
  pwm: add CSR SiRFSoc PWM driver
  pwm: sirf: add dt-binding document
  ARM: dts: sirf: fix the pwm-cells and clocks
  ARM: prima2_defconfig: enable PWM and sirf PWM driver

 Documentation/devicetree/bindings/pwm/pwm-sirf.txt |  29 ++
 arch/arm/boot/dts/atlas6.dtsi                      |   8 +-
 arch/arm/boot/dts/prima2.dtsi                      |   8 +-
 arch/arm/configs/prima2_defconfig                  |   2 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sirf.c                             | 450 +++++++++++++++++++++
 7 files changed, 504 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
 create mode 100644 drivers/pwm/pwm-sirf.c

-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
