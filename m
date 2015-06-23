From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [v2 4/7] mfd: intel_soc_pmic_core: ADD PWM lookup
 table for CRC PMIC based PWM
Date: Tue, 23 Jun 2015 08:19:21 +0100
Message-ID: <20150623071921.GE3245@x1>
References: <1434970465-12687-1-git-send-email-shobhit.kumar@intel.com>
 <1434970465-12687-5-git-send-email-shobhit.kumar@intel.com>
 <5587EB7A.5090402@gmail.com>
 <20150622141908.GM25769@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20150622141908.GM25769@phenom.ffwll.local>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Shobhit Kumar <shobhit.kumar@intel.com>, linux-pwm <linux-pwm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-gpio <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Samuel Ortiz <sameo@linux.intel.com>, Povilas Staniulis <wdmonster@gmail.com>, Jani Nikula <jani.nikula@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, bloften80@gmail.com, David Airlie <airlied@linux.ie>, Chih-Wei Huang <cwhuang@android-x86.org>, Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCAyMiBKdW4gMjAxNSwgRGFuaWVsIFZldHRlciB3cm90ZToKCj4gT24gTW9uLCBKdW4g
MjIsIDIwMTUgYXQgMDQ6MzM6MjJQTSArMDUzMCwgVmFya2EgQmhhZHJhbSB3cm90ZToKPiA+IEhp
IFNob2JoaXQgS3VtYXIsCj4gPiAKPiA+IE9uIDA2LzIyLzIwMTUgMDQ6MjQgUE0sIFNob2JoaXQg
S3VtYXIgd3JvdGU6Cj4gPiAKPiA+ID5PbiBzb21lIEJZVCBQTGF0Zm9ybSB0aGUgUFdNIGlzIGNv
bnRyb2xsZWQgdXNpbmcgQ1JDIFBNSUMuIEFkZCBhIGxvb2t1cAo+ID4gPmVudHJ5IGZvciB0aGUg
c2FtZSB0byBiZSB1c2VkIGJ5IHRoZSBjb25zdW1lciAoSW50ZWwgR0ZYKQo+ID4gPgo+ID4gPnYy
OiBSZW1vdmUgdGhlIGxvb2t1cCB0YWJsZSBvbiBkcml2ZXIgdW5sb2FkIChUaGllcnJ5KQo+ID4g
Pgo+ID4gPnYzOiBDb3JyZWN0IHRoZSBzdWJqZWN0IGxpbmUgKExlZSBqb25lcykKPiA+IAo+ID4g
VGhpcyBwYXJ0IHNob3VsZCBvbmx5IGRlc2NyaWJlIHdoYXQgdGhpcyBpcyBhYm91dC4uCj4gPiAK
PiA+IERvbid0IHB1dCB0aGlzIHBhdGNoIGNoYW5nZSBoaXN0b3J5IG92ZXIgaGVyZS4KPiA+IElu
Y2x1ZGUgdGhpcyBjaGFuZ2UgaGlzdG9yeSBhZnRlcgo+ID4gLi4uCj4gPiBTaWduZWQtb2ZmLWJ5
OiBBdXRob3IgPGVtYWlsPgo+ID4gLS0tCj4gPiAKPiA+ID5DQzogU2FtdWVsIE9ydGl6IDxzYW1l
b0BsaW51eC5pbnRlbC5jb20+Cj4gPiA+Q2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpA
bGluYXJvLm9yZz4KPiA+ID5DYzogQWxleGFuZHJlIENvdXJib3QgPGdudXJvdUBnbWFpbC5jb20+
Cj4gPiA+Q2M6IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5jb20+Cj4gPiA+
QWNrZWQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4gPiA+U2lnbmVkLW9m
Zi1ieTogU2hvYmhpdCBLdW1hciA8c2hvYmhpdC5rdW1hckBpbnRlbC5jb20+Cj4gPiA+LS0tCj4g
PiAKPiA+IEhlcmUgeW91IGFkZCB0aGlzIGNoYW5nZSBoaXN0b3J5IHNvIHRoYXQgYWZ0ZXIgYXBw
bHlpbmcgdGhpcwo+ID4gd2lsbCBub3QgYmUgdGhlIHBhcnQgb2YgeW91ciBjb21taXQgZGVzY3Jp
cHRpb24uCj4gPiAKPiA+IFRoaXMgY29tbWVudCBpcyBhcHBsaWNhYmxlIGZvciBhbGwgb2YgeW91
ciBwYXRjaGVzLgo+IAo+IEl0J3MgaG9uZXN0bHkgYSBwZXItbWFpbnRhaW5lciB0aGluZyBhbmQg
aGFyZCB0byB0ZWxsIHdobyB3YW50cyB3aGF0IC4uLgo+IFBlcnNvbmFsbHkgSSBkbyB3YW50IHRv
IGluY2x1ZGUgdGhlIHBhdGNoIGNoYW5nZWxvZyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuCgpUaGUg
cGF0Y2ggY2hhbmdlLWxvZyBzaG91bGQgZ28gYmVsb3cgdGhlICctLS0nLiAgVGhlcmUgYXJlIHZl
cnkgZmV3Cih3ZWlyZCA7KSApIE1haW50YWluZXJzIHdobyBsaWtlIHRvIHNlZSB0aGVtIGluIHRo
ZSBjb21taXQgbG9nLgoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNyb2VsZWN0cm9uaWNzIExh
bmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBB
Uk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkludGVsLWdmeCBtYWlsaW5n
IGxpc3QKSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
