From: Simon Horman <horms@verge.net.au>
Subject: Re: PWM...
Date: Tue, 21 Jan 2014 09:39:22 +0900
Message-ID: <20140121003922.GA31997@verge.net.au>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
 <20140120001446.GD9752@verge.net.au>
 <20140120161147.GS17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140120161147.GS17314@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-pwm@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jan 20, 2014 at 04:11:47PM +0000, Mark Brown wrote:
> On Mon, Jan 20, 2014 at 09:14:46AM +0900, Simon Horman wrote:
> > On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:
> 
> > > Right: if you change an existing dts file from #pwm-cells=<2> to
> > > #pwm-cells=<3>, that requires changing all references to the pwm
> 
> > Would this change imply that old dtbs would no longer work with new kernels?
> 
> So long as the code can still handle both values for #pwm-cells existing
> DTBs should work fine.

Thanks, as long as that is the case I have no objections at this time.
