From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [rfc]pwm: add BCM2835 PWM driver
Date: Mon, 14 Apr 2014 09:47:22 -0600
Message-ID: <534C030A.80602@wwwdotorg.org>
References: <1396532680-30352-1-git-send-email-bart.tanghe@thomasmore.be>	<CAAYSxhpTV1-k7ROzJnnOhNcrZRUTzAfFc6YtLKLx6oZVUEHNxQ@mail.gmail.com>	<5344A209.7010507@wwwdotorg.org> <CAAYSxhqv_RLfksBE-n8KMg33v6ZfB4B4E8NQUYf8JsPzVrLYzw@mail.gmail.com> <534BB90B.7030904@thomasmore.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <534BB90B.7030904@thomasmore.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>, Tim Kryger <tim.kryger@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 04/14/2014 04:31 AM, Bart Tanghe wrote:
> Is it the responsibility of the pwm driver to handle the pinmux of the
> io pins? Or is the end user, or a parent driver responsible to handle this?
> Idem for the clock?

The pinmux driver is responsible for writing to the pinmux registers.
This can be set up either statically so it happens at system boot, or
dynamically so that it's triggered by the SPI/... driver. Statically is
preferred uneless there's a need to change the pinmux back/forth between
different configurations at run-time.

Any clock programming should be performed by a clock driver. We don't
have one of those upstream yet, mainly because it would rely on talking
to the firmware (running on the VideoCore) to manipulate the clocks, and
we don't have a firmware protocol driver either.
