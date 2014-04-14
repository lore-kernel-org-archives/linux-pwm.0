From: Bart Tanghe <bart.tanghe-2dq7lIxLGp5qkBXjtECzWg@public.gmane.org>
Subject: Re: [rfc]pwm: add BCM2835 PWM driver
Date: Mon, 14 Apr 2014 12:31:39 +0200
Message-ID: <534BB90B.7030904@thomasmore.be>
References: <1396532680-30352-1-git-send-email-bart.tanghe@thomasmore.be>	<CAAYSxhpTV1-k7ROzJnnOhNcrZRUTzAfFc6YtLKLx6oZVUEHNxQ@mail.gmail.com>	<5344A209.7010507@wwwdotorg.org>
 <CAAYSxhqv_RLfksBE-n8KMg33v6ZfB4B4E8NQUYf8JsPzVrLYzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAAYSxhqv_RLfksBE-n8KMg33v6ZfB4B4E8NQUYf8JsPzVrLYzw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Is it the responsibility of the pwm driver to handle the pinmux of the 
io pins? Or is the end user, or a parent driver responsible to handle this?
Idem for the clock?


On 04/09/2014 05:59 PM, Tim Kryger wrote:
> On Tue, Apr 8, 2014 at 6:27 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 04/08/2014 05:02 PM, Tim Kryger wrote:
>>> On Thu, Apr 3, 2014 at 6:44 AM, Bart Tanghe <bart.tanghe-2dq7lIxLGp5qkBXjtECzWg@public.gmane.org> wrote:
>>>> need some recommendation
>>>> the memory mapped io registers of the bcm2835 pwm hardware are spreaded
>>>> over the memory mapped io
>>>> gpio config 0x20200004 - clk config 0x201010A0 - pwm configuration 0x2020C000
>>>> to handle this, I've used the base address of the memory mapped io
>>>> so I can use positive offsets
>>> So the registers for this PWM are located in three distinct memory regions?
>> ...
>>>> +struct bcm2835_pwm_chip {
>>>> +       struct pwm_chip chip;
>>>> +       struct device *dev;
>>>> +       int channel;
>>>> +       void __iomem *mmio;
>>> One pointer isn't going to be enough.  You need three.
>>>
>>> I suggest renaming the first and adding two more:
>>>
>>> void __iomem *base_pwm;
>>> void __iomem *base_clk;
>>> void __iomem *base_alt;
>> Sorry, I forgot about this patch. One comment here; the PWM driver can't
>> touch the clock or alt registers; those should be owned by the clock
>> driver, and the driver for whatever alt is (pinmux - don't recall what
>> it's touching there).
> Absolutely.  If these registers are owned by other drivers, go through them.
