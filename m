From: Liu Ying <Ying.Liu@freescale.com>
Subject: Re: [PATCH v2] pwm: i.MX: Avoid sample fifo overflow for i.MX pwm
 version2
Date: Tue, 22 Apr 2014 16:48:44 +0800
Message-ID: <53562CEC.6040902@freescale.com>
References: <1397121829-19331-1-git-send-email-Ying.Liu@freescale.com>
 <20140413074643.GD24180@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140413074643.GD24180@dragon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, LW@KARO-electronics.de
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 04/13/2014 03:46 PM, Shawn Guo wrote:
> On Thu, Apr 10, 2014 at 05:23:49PM +0800, Liu Ying wrote:
>> The i.MX pwm version2 is embedded in several i.MX SoCs, such
>> as i.MX27, i.MX51 and i.MX6SL.  There are four 16bit sample
>> fifos in this IP, each of which determines the duty period
>> of a PWM waveform in one full cycle.  The IP spec mentions
>> that we should not write a fourth sample because the fifo
>> will become full and trigger a fifo write error(FWE) which
>> will prevent the PWM from starting once it is enabled.  In
>> order to avoid any sample fifo overflow issue, this patch
>> does software reset to clear all the sample fifos in the
>> very beginning of the pwm configuration function.
>>
>> The fifo overflow issue can be reproduced by the following
>> commands on the i.MX6SL evk platform, assuming we use pwm2
>> for the debug LED which is driven by the pin HSIC_STROBE
>> and the maximal brightness is 255.
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 0   > /sys/class/leds/user/brightness
>> echo 255 > /sys/class/leds/user/brightness
>> Here, FWE happens(PWMSR register reads 0x58) and the LED
>> can not be lighten.
>>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> Cc: Shawn Guo <shawn.guo@freescale.com>
> =

> Acked-by: Shawn Guo <shawn.guo@freescale.com>
> =

>> Cc: Lothar Wa=DFmann <LW@KARO-electronics.de>
>> Cc: linux-pwm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> =


I've got Shawn's ack on this patch.
If no objections, could you take it into your PWM tree?

Thanks.

-- =

Liu Ying
