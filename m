From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 02/48] ARM: at91: Document new TCB bindings
Date: Tue, 21 Jun 2016 15:28:00 -0500
Message-ID: <20160621202800.GB22435@rob-hp-laptop>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1465596231-21766-3-git-send-email-alexandre.belloni@free-electrons.com>
 <20160614214737.GA10294@rob-hp-laptop>
 <20160615092955.261f14fb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160615092955.261f14fb@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 15, 2016 at 09:29:55AM +0200, Boris Brezillon wrote:
> On Tue, 14 Jun 2016 16:47:37 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sat, Jun 11, 2016 at 12:03:05AM +0200, Alexandre Belloni wrote:
> > > The current binding for the TCB is not flexible enough for some use cases
> > > and prevents proper utilization of all the channels.
> > > 
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > Cc: linux-pwm@vger.kernel.org
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/arm/atmel-at91.txt         | 32 -----------
> > >  .../devicetree/bindings/mfd/atmel-tcb.txt          | 62 ++++++++++++++++++++++
> > >  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
> > >  3 files changed, 69 insertions(+), 37 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt  
> > 
> > [...]


> > > diff --git a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > > index 8031148bcf85..ab8fbd5ba184 100644
> > > --- a/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > > +++ b/Documentation/devicetree/bindings/pwm/atmel-tcb-pwm.txt
> > > @@ -2,15 +2,17 @@ Atmel TCB PWM controller
> > >  
> > >  Required properties:
> > >  - compatible: should be "atmel,tcb-pwm"
> > > +- reg: tcb channel to use. Each channel can export 2 PWMs  
> > 
> > Is there a difference in channels? If not, then this compatible should 
> > go.
> 
> This one I don't understand.
> The TCB (Timer Counter Block) is an MFD containing 3 Timer Counter
> devices. Each of these devices (also called channels) can be assigned a
> specific mode:
> - timer mode (free-running of programmable)
> - waveform generator mode (IOW, a PWM)
> - capture mode (an IIO device, but we don't have any driver for that
>   right now)
> 
> So each sub-device of the TCB is represented as a sub-node with its own
> compatible. Is there a problem with that?

Missed this in my first reply. I guess for purposes of referencing pwm 
from other nodes this is okay.

Rob
