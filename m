From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCHv9 0/2] Add Allwinner SoCs PWM support
Date: Tue, 18 Nov 2014 14:47:33 +0100
Message-ID: <546B4DF5.9020100@schinagl.nl>
References: <1415200545-26238-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415200545-26238-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Simon <longsleep@gmail.com>
List-Id: linux-pwm@vger.kernel.org

Hey Alexandre,

On 05-11-14 16:15, Alexandre Belloni wrote:
> Hi,
>
> This patch series adds support for the PWM controller found on the Allwinner
> SoCs.
>
> The first patch adds the driver itself.
> The second patch adds the DT binding documentation
>
> Changes in v8:
>   - renamed the driver sun4i as the PWM IP is different in the next sunxi SoCs
Why did you decide to rename it to sun4i? From your bindings document I 
understand you still support sun4i and sun7i, what happened to sun5i?

I went over the datasheets of sun4i, sun5i and sun7i and the disp_lcd.c 
from the latest linux-sunxi kernels and have to agree, they are all 4 
inconsistent and messy, but I'm not sure what you mean with PWM IP is 
different in next sunxi soc's. is sun5i different to sun4i? is sun7i 
different? or is sun6i (A31), sun8i (a80) and sun9i (A23) different?


What I get from the datasheet is, that sun4i and sun5i are exactly the 
same, with the exception that sun5i only has 1 PWM (~exposed~). I belive 
that is easily solved with the bindings by having allwinner-sun4i and 
allwinner sun5i bindings if I'm not mistaken.

As for sun7i compared to the other ones, according to disp_lcd.c sun5i 
and sun7i should behave exactly the same. This is contradicting to the 
datasheet, where sun4i and sun5i are the same.

So what are the major differences that I can see between the 3? sun4i 
defines the PWM prescaler register value 0b1111 as being undefined, and 
sun5i and sun7i as /1? Did you verify this (I haven't I admit, i bumped 
into this while looking for your patch ;-) )? I wouldn't be supprised if 
it where a typo on allwinners end in the datasheet ... disp_lcd.c stops 
at 72000 for the last entry. We should just check sun4i, sun5i and sun7i 
hardware to see if it behaves the same with a prescaler of 0b1111, which 
I would not be totally surprised if it did.

The other difference I notice is that sun7i and sun5i use 16bit period 
register where sun4i uses a 8bit register. This is probably the only 
reason why they put a #ifdef in disp_lcd.c, calculations turn out 
differently. I don't recognize this behavior at all in your driver 
however. I do think they that there is a difference here, since they did 
split up the original driver here because of this difference.

The pre-scaler bypass bit and pwm ready bit you all ready take care of :)

Finally, though I'm sure I should have replied to it inline in the 
actual code, but hoping i can let it slip through here is that you 
define your local data as:

+ static const struct sun4i_pwm_data sun4i_pwm_data_a20 = {

which looks really strange to me, since there is no a20 using the sun4i 
architecture :) I know it's just nitpicking, it just looks really odd. 
Maybe the compatible naming works just as well? sun4i_pwm_data; 
sun7i_pwm_data (and sun5i_pwm_data if you want to take care of only 
pwm0, only pwm1 (if we ever encounter such a configuration, disabled 
pwm0, enabled pwm1) or both to be used?)

Sorry for the long naggy mail, just looking for clarification as I'm 
going to be using your patch ;)

Olliver

>   - Took into account comments from Thierry
>
> Changes in v9:
>   - moved from using a mutex to a spinlock
>
> Alexandre Belloni (2):
>    pwm: Add Allwinner SoC support
>    pwm: sunxi: document OF bindings
>
>   .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
>   drivers/pwm/Kconfig                                |   9 +
>   drivers/pwm/Makefile                               |   1 +
>   drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++++++
>   4 files changed, 396 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>   create mode 100644 drivers/pwm/pwm-sun4i.c
>
