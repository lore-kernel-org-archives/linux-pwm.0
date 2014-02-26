From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Wed, 26 Feb 2014 16:19:27 +0000 (UTC)
Message-ID: <lel46f$q2d$1@ger.gmane.org>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Barry,

On 2014-02-08, Barry Song <21cnbao@gmail.com> wrote:
> From: Rongjun Ying <Rongjun.ying@csr.com>
>
> PWM controller of CSR SiRFSoC can generate 7 independent outputs. Each output
> duty cycle can be adjusted by setting the corresponding wait & hold registers.
>
> Supports 7 independent channel output: 6 for external(channel0-5) and 1 for
> internal(channel6).
>
> Supports wide frequency range: divide by 2 to 65536*2 of source clock.
>
> Signed-off-by: Rongjun Ying <Rongjun.ying@csr.com>
> Signed-off-by: Huayi Li <Huayi.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v3:
>  add "depends on" COMPILE_TEST according to Arnd's feedback;
>  move the pwm clock source to dts according to Arnd's feedback;
>  add lost dt-binding document
>
>  Documentation/devicetree/bindings/pwm/pwm-sirf.txt |   17 +
>  arch/arm/boot/dts/atlas6.dtsi                      |    3 +-
>  arch/arm/boot/dts/prima2.dtsi                      |    3 +-
>  drivers/pwm/Kconfig                                |    9 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-sirf.c                             |  308 ++++++++++++++++++++
>  6 files changed, 339 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sirf.txt
>  create mode 100644 drivers/pwm/pwm-sirf.c
>
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sirf.txt b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
> new file mode 100644
> index 0000000..4b10109
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sirf.txt
> @@ -0,0 +1,17 @@
> +SiRF prima2 & atlas6 PWM drivers
> +
> +Required properties:
> +- compatible: "sirf,prima2-pwm"
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: should be 2.  The first cell specifies the per-chip index
> +  of the PWM to use and the second cell is the period in nanoseconds.
> +- clocks: from common clock binding: the 1st clock is for PWM controller
> +  the 2nd clock is the source to generate PWM waves
> +

Describing the clocks this way seems limiting to me.

Each output of the PWM controller on SiRFatlasVI and SiRFprimaII can
independently use one clock among many for signal generation, with
three PLLs and two external clock inputs available.

If we specify the source clock for the signal generation in the device
tree as you do here, we will prevent the use of those different input
clocks when incompatible frequencies are required, such as 32,768 Hz on
one output line and 44,100 Hz on another one.

As the clock tree for SiRF SoCs is described in the source files in
drivers/clk/sirf/*, it does not appear to me that the functional clock
needs to be configured in the device tree: the names of available clock
sources can be provided statically by the device tree matching table the
pwm-sirf.c.  Moreover, this would continue to work with the current
(undocumented) bindings for SiRFatlasVI and SiRFprimaII.

Alternatively, to keep the configuration in the device tree, all valid
inputs for this SoC could be described here, instead of a single one.

The choice of the clock used for each output can then be selected when
configuring an output, with a selection algorithm using the best input for
a given period in of_xlate() and config() callbacks.

-- 
Romain Izard
