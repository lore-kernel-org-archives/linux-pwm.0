From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv8 1/2] pwm: Add Allwinner SoC support
Date: Mon, 20 Oct 2014 12:29:39 +0200
Message-ID: <20141020102939.GB10616@piout.net>
References: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413743305-1979-2-git-send-email-alexandre.belloni@free-electrons.com>
 <54442BB1.1080403@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <54442BB1.1080403@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, jonsmirl@gmail.com, Simon <longsleep@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On 20/10/2014 at 00:22:57 +0300, Vladimir Zapolskiy wrote :
> > +struct sun4i_pwm_chip {
> > +	struct pwm_chip chip;
> > +	struct clk *clk;
> > +	void __iomem *base;
> > +	struct mutex ctrl_lock;
> 
> why do you use mutex? I haven't found any blocking subcalls under
> protection, a spinlock seems to fit better here.
> 

A mutex here will do the right thing. The lock is never taken in
interrupt context and a mutex is spinning for a few cycles before
putting the thread to sleep. I'm not sure why you feel a spinlock would
be better here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
