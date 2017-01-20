From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: lpss: Make builtin so that i915 can
 find the pwm_backlight
Date: Fri, 20 Jan 2017 09:56:17 +0100
Message-ID: <20170120085617.GG4894@ulmo.ba.sec>
References: <20170119175830.3754-1-hdegoede@redhat.com>
 <20170120070333.GD4894@ulmo.ba.sec> <8737gei2fp.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0531987185=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <8737gei2fp.fsf@intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pwm@vger.kernel.org


--===============0531987185==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 10:02:50AM +0200, Jani Nikula wrote:
> On Fri, 20 Jan 2017, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Thu, Jan 19, 2017 at 06:58:30PM +0100, Hans de Goede wrote:
> >> The primary consumer of the lpss pwm is the i915 kms driver,
> >> the i915 driver does not support get_pwm returning -EPROBE_DEFER and
> >> its init is very complex making this is almost impossible to fix.
> >>=20
> >> This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
> >> that when the i915 driver loads the lpss pwm will be available avoiding
> >> the -EPROBE_DEFER issue. Note that this is identical to how the same
> >> problem was solved for the pwm-crc driver, which is used by the i915
> >> driver on other platforms.
> >>=20
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> Acked-by: Jani Nikula <jani.nikula@intel.com>
> >> ---
> >> Changes in v2:
> >> -Drop the pwm_add_table call (this has been moved to the acpi_lpss dri=
ver)
> >> ---
> >>  drivers/pwm/Kconfig | 12 +++---------
> >>  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > For the record I think this is completely wrong and i915 should be
> > taught how to deal with -EPROBE_DEFER. We've gone through a lot of
> > pain to clean up this kind of init-level ordering on other devices
> > and the result is, in my opinion, a *lot* better than what we had
> > before. It'd be shame to see i915 backpedal on that.
> >
> > That said, if everyone else thinks that it really can't be done and
> > this workaround is the best way forward, I'll just shut up about it
> > and stop caring.
>=20
> Superficially, it is, of course, easy to agree we should handle deferred
> probing.
>=20
> i915 is a complex driver for complex hardware. We require a ton of
> initialization before we even get to the point we realize we might need
> the PWM. Naturally, we'd need to gracefully tear all that down for
> -EPROBE_DEFER handling. And we've been slowly working towards this;
> we've even added injected probe failures in CI to test this. But we're
> not there yet. This patch seems like a rather simple workaround for the
> time being.
>=20
> There are two other related things I wonder about.
>=20
> I see module reloading mostly as a developer feature. I don't think I'm
> alone in that. You just don't recommend anyone doing module reloads in a
> production environment. However, deferred probing is in some ways more
> demanding than module reload, because it needs to gracefully handle
> partial probes. Yet that is the solution of choice for init
> ordering. Makes you wonder.

Well, there have been proposals in the past to get rid of deferred
probing by replacing it with something more formal, but it's a fairly
difficult issue to solve. While deferred probing is indeed a rather
heavy-weight solution, it's one that's proven to work well enough for
most of the world.

Also gracefully handling partial probes is something you need in most
cases anyway. Typically the easiest solution is to make sure to run all
the code that could possibly fail as early as possible, like Hans had
suggested, so that you need to unwind as little as possible.

> Another thing that comes up a lot with graphics is that people really do
> appreciate any crappy degraded image over a black screen. If the PWM
> never shows up, all the external screens will be black in addition to
> the embedded display. We're always torn between failing fast
> vs. plunging on despite failures.

Yes, I see how deferred probe would get in the way here. To be fair,
deferred probing was never meant to solve this kind of use-case. One
of the reasons why it is so heavy-weight is that drivers can usually
not continue without the resources they're trying to get.

In this particular case, however, only a very small subset of the driver
relies on the PWM, so it's more of an optional, nice to have, resource
rather than an essential one.

> That said, I suppose there could be an alternative to handling pwm_get()
> failures at probe. We could just go on with our init, but schedule a
> retry later. Perhaps a bit hacky, but it would address both of the
> concerns above. Again, this patch seems a simple workaround in the mean
> time.

I don't think that's hacky at all. In fact I think it's a really nice
solution for this particular case and could probably be a good fit for
other use-cases as well.

As for adding a simple workaround in the meantime, is that really
necessary? This doesn't really fix any bugs, right? Its just that new
hardware may not work properly, isn't it? I'm somewhat reluctant to
temporarily add this workaround because I know Paul Gortmaker will
immediately send out a patch to make the driver use builtin_{pci,
platform}_driver and all of a sudden we've got a bunch of things to
untangle because of a "simple workaround".

Hans, do you think you could find some time to at least investigate
whether or not Jani's proposal above would be a viable option that
wouldn't take ages to implement? If it's excessively complicated to
do, I'm okay with this patch, though you may want to do the module_*
to builtin_* conversion while at it to save Paul the extra work. And
maybe add a comment somewhere that this is meant to be a temporary
workaround until i915 can deal with this more nicely?

Thanks,
Thierry

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB0K4ACgkQ3SOs138+
s6HIPBAAmf2R8U609bwYKcS0YgGtsskkHMHhBc8IvICVBeAhU0oqERmzZJqvbBIj
QnGbL3QKerthprxZOMr0TKmnUWXXeEaWjuwKiry/H8Wg5+GZJ1KLSAxdldDpOreY
YEx6na4vrbfn/z2SVjlA7FI1tWpXLiEIGht5MDXgHrkQD8XtUJnRFI/yMYX2V9bn
QEl1ngxvsxAX1bc2lZwv15uuK5gkALrCMh63uauFiGnNVuXKIvevzsvbSLpEkTV/
gHX5rEEB2qocKkaE6YTXK+6xLlN2QCl2iornsHkj2wjOTikv3YVt6PFcfUid8Cg7
VaHazQUt7zncZtMZEHmxALzs+cG6KpYn/7G8GSdnEy9GnfcNNyubSr1/BdpVo+bd
l6eI6F4agHj93CWHKRpCGJlPeP9hh9Q0jGYX2FY1C5Xpsgyll/jO0crgpodY4wSH
iH3YzFyY7TcrOnUNHC8swqXAA+EDAyLP75rxetA2zPWpHf38tgs3TUx7rc6pQCvQ
W9wK397LhZbDOw/OIqtTPwdZE8mzs6T1YiPAGX5SCjTec+L5wNYqyN4WyaXkEn5T
4MgxxJCXKY0eiLnJ8JVrjH1F6RmTzUTEpAGNlPevl3VDD365VuM65mkecpE3bD+t
kRSu589GuH8X9odJ6Ljv/Ov6Mcp7nGdQFj14AGHO8ZIGmPyFAjw=
=rrpm
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--

--===============0531987185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0531987185==--
