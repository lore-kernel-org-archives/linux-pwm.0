From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 1/2] PWM: atmel: fix incorrect CDTY value after enabling
Date: Tue, 26 May 2015 13:51:55 +0200
Message-ID: <20150526115155.GF3199@piout.net>
References: <1432559996-4415-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5564366D.9090707@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5564366D.9090707@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 26/05/2015 at 11:01:33 +0200, Nicolas Ferre wrote :
> Le 25/05/2015 15:19, Alexandre Belloni a =E9crit :
> > CUPD is not flushed before enabling the channel so it will update CDTY/=
CPRD just
> > after one period. So we always set CUPD, even when the channel is not e=
nabled.
> > =

> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> =

> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> =

> BTW, is a "stable tag" needed for this one?
> =


I had a look and both can probably be backported up to 3.14.

-- =

Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
